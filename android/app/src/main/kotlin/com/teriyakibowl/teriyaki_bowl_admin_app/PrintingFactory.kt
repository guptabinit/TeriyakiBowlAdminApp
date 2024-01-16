package com.teriyakibowl.teriyaki_bowl_admin_app

import android.graphics.BitmapFactory
import android.util.Log
import com.starmicronics.stario10.InterfaceType
import com.starmicronics.stario10.StarConnectionSettings
import com.starmicronics.stario10.StarPrinter
import com.starmicronics.stario10.starxpandcommand.DocumentBuilder
import com.starmicronics.stario10.starxpandcommand.PrinterBuilder
import com.starmicronics.stario10.starxpandcommand.StarXpandCommandBuilder
import com.starmicronics.stario10.starxpandcommand.printer.ImageParameter
import com.starmicronics.stario10.starxpandcommand.printer.InternationalCharacterType
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import android.content.Context
import com.starmicronics.stario10.starxpandcommand.MagnificationParameter
import com.starmicronics.stario10.starxpandcommand.printer.Alignment
import com.starmicronics.stario10.starxpandcommand.printer.CutType
import io.flutter.plugin.common.MethodCall

class PrintingFactory(
    call: MethodCall,
    result: MethodChannel.Result,
) {

    private var call: MethodCall
    private var result: MethodChannel.Result

    init {
        this.call = call
        this.result = result
    }

    fun print(
        context: Context,
        interfaceType: InterfaceType,
        identifier: String,
    ) {
        val settings = StarConnectionSettings(interfaceType, identifier)
        val printer = StarPrinter(settings, context)

        if (interfaceType == InterfaceType.Bluetooth || settings.autoSwitchInterface) {
            if (!MainActivity.hasBluetoothPermission(context)) {
                result.error(
                    "no_permission",
                    "You have to allow Nearby devices to use the Bluetooth printer.",
                    null
                )
                return
            }
        }

        val job = SupervisorJob()
        val scope = CoroutineScope(Dispatchers.Default + job)

        scope.launch {
            try {
                val builder = StarXpandCommandBuilder()

                val printerBuilder = PrinterBuilder()

                val logo = BitmapFactory.decodeResource(context.resources, R.drawable.ic_app_logo)

                printerBuilder.styleAlignment(Alignment.Center)
                    .actionPrintImage(ImageParameter(logo, 120))

                printerBuilder.styleInternationalCharacter(InternationalCharacterType.Usa)

                printerBuilder.add(
                    PrinterBuilder().styleAlignment(Alignment.Center).styleBold(true)
                        .styleMagnification(MagnificationParameter(2, 2))
                        .actionPrintText("\nTeriyaki Bowl")
                )


                printerBuilder.add(PrinterBuilder().actionPrintText("\n------------------------------------------------"))

                printerBuilder.add(
                    PrinterBuilder().styleAlignment(Alignment.Left).actionPrintText("Customer Name")
                )

                val customerName = call.argument<String?>("customer_name")
                if (customerName != null) {
                    printerBuilder.add(
                        PrinterBuilder().styleAlignment(Alignment.Left)
                            .styleMagnification(MagnificationParameter(2, 2))
                            .actionPrintText(customerName)
                    )
                }


                printerBuilder.add(
                    PrinterBuilder().styleAlignment(Alignment.Left).actionPrintText("Pickup Time")
                )

                val pickupTime = call.argument<String?>("pickup_time")
                if (pickupTime != null) {
                    printerBuilder.add(
                        PrinterBuilder().styleAlignment(Alignment.Left)
                            .styleMagnification(MagnificationParameter(2, 2))
                            .actionPrintText(pickupTime)
                    )
                }

                printerBuilder
                    .add(
                        PrinterBuilder().styleAlignment(Alignment.Left)
                            .actionPrintText("Order Number")

                    )

                val orderNumber = call.argument<String?>("order_number")
                if (orderNumber != null) {
                    printerBuilder.add(
                        PrinterBuilder().styleAlignment(Alignment.Left)
                            .styleMagnification(MagnificationParameter(2, 2))
                            .actionPrintText(orderNumber)
                    )
                }

                printerBuilder.add(
                    PrinterBuilder().styleAlignment(Alignment.Left).actionPrintText("Total Items")
                )

                val totalItems = call.argument<String?>("total_items")
                if (totalItems != null) {
                    printerBuilder.add(
                        PrinterBuilder().styleAlignment(Alignment.Left)
                            .styleMagnification(MagnificationParameter(2, 2))
                            .actionPrintText(totalItems)
                    )
                }

                printerBuilder.add(PrinterBuilder().actionPrintText("------------------------------------------------"))

                val items = call.argument<List<Map<String, Any>>?>("items") ?: listOf()
                for (item in items) {

                    val itemV = item["item"] as? String
                    if (itemV != null) {
                        printerBuilder.add(
                            PrinterBuilder().styleBold(true).styleAlignment(Alignment.Left)
                                .actionPrintText(itemV)
                        )
                    }

                    val modifiers = item["modifiers"] as? String
                    if (modifiers != null) {
                        printerBuilder.add(
                            PrinterBuilder().styleBold(false).styleAlignment(Alignment.Left)
                                .actionPrintText(modifiers)
                        )
                    }
                }
                val subTotal = call.argument<String?>("sub_total")
                val tax = call.argument<String?>("tax")

                if (subTotal != null && tax != null) {
                    printerBuilder.add(
                        PrinterBuilder().actionPrintText(subTotal).actionPrintText(tax)
                    )
                }

                val total = call.argument<String?>("total")
                if (total != null) {
                    printerBuilder.add(PrinterBuilder().styleBold(true).actionPrintText(total))
                }
                printerBuilder.actionCut(CutType.Partial)

                builder.addDocument(DocumentBuilder().addPrinter(printerBuilder))

                val commands = builder.getCommands()

                printer.openAsync().await()
                printer.printAsync(commands).await()

            } catch (e: Exception) {
                Log.d("Printing", "Error: $e")
                result.error(
                    "failed",
                    e.message,
                    e.stackTrace.toString()
                )
            } finally {
                printer.closeAsync().await()
            }
        }
    }

}