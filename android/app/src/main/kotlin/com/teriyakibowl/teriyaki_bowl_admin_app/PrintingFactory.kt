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
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.launch
import android.content.Context
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Rect
import android.graphics.Typeface
import android.text.Layout
import android.text.StaticLayout
import android.text.TextPaint
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

                val logo = BitmapFactory.decodeResource(context.resources, R.drawable.ic_app_logo)

                val headerPrintingData = call.argument<String?>("header_printing_data") ?: ""
                val bodyPrintingData = call.argument<String?>("body_printing_data") ?: ""
                val footerPrintingData = call.argument<String?>("footer_printing_data") ?: ""

                val builder = StarXpandCommandBuilder()
                builder.addDocument(
                    DocumentBuilder()
                        .addPrinter(
                            PrinterBuilder()
                                .styleAlignment(Alignment.Center)
                                .actionPrintImage(ImageParameter(logo, 70))
                                .actionPrintImage(
                                    createImageParameterFromText(
                                        headerPrintingData,
                                        20
                                    )
                                )
                                .actionPrintImage(
                                    createImageParameterFromText(
                                        bodyPrintingData,
                                        20
                                    )
                                )
                                .actionPrintImage(
                                    createImageParameterFromText(
                                        footerPrintingData,
                                        20
                                    )
                                )
                                .actionCut(CutType.Partial)
                        )
                )

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

    private fun createImageParameterFromText(text: String, fontSize: Int): ImageParameter {
        val width = 560
        val typeface = Typeface.create(Typeface.MONOSPACE, Typeface.NORMAL)
        val bitmap = createBitmapFromText(text, fontSize, width, typeface);
        return ImageParameter(bitmap, width)
    }

    private fun createBitmapFromText(
        text: String, textSize: Int, width: Int, typeface: Typeface?,
    ): Bitmap {
        val paint = Paint()
        val bitmap: Bitmap
        paint.textSize = textSize.toFloat()
        paint.typeface = typeface
        paint.getTextBounds(text, 0, text.length, Rect())
        val textPaint = TextPaint(paint)
        val builder = StaticLayout.Builder.obtain(text, 0, text.length, textPaint, width)
            .setAlignment(Layout.Alignment.ALIGN_NORMAL)
            .setLineSpacing(0f, 1f)
            .setIncludePad(false)

        val staticLayout = builder.build()

        // Create bitmap
        bitmap = Bitmap.createBitmap(
            staticLayout.width,
            staticLayout.height,
            Bitmap.Config.ARGB_8888
        )

        // Create canvas
        val canvas: Canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)
        canvas.translate(0f, 0f)
        staticLayout.draw(canvas)
        return bitmap
    }

}