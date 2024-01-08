package com.teriyakibowl.teriyaki_bowl_admin_app

import android.util.Log
import com.starmicronics.stario10.InterfaceType
import com.starmicronics.stario10.StarDeviceDiscoveryManager
import com.starmicronics.stario10.StarPrinter
import io.flutter.embedding.android.FlutterActivity
import android.os.Build
import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import com.starmicronics.stario10.StarDeviceDiscoveryManagerFactory
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.teriyaki-bowl/star-io10"

    private var manager: StarDeviceDiscoveryManager? = null


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startDiscovery" -> {

                    requestBluetoothPermission(applicationContext, this)

                    val interfaceType =
                        getInterfaceType(call.argument<String>("interfaceType") ?: "unknown")

                    startDiscovery(interfaceType, result)
                }

                "print" -> {
                    val identifier = call.argument<String?>("identifier")

                    val interfaceType =
                        getInterfaceType(call.argument<String>("interfaceType") ?: "unknown")

                    val printingFactory = PrintingFactory(call, result)
                    if (identifier != null) {
                        printingFactory.print(
                            applicationContext,
                            interfaceType,
                            identifier
                        )
                    }

                }

                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun startDiscovery(interfaceType: InterfaceType, result: MethodChannel.Result) {
        // If you are using Android 12 and targetSdkVersion is 31 or later,
        // you have to request Bluetooth permission (Nearby devices permission) to use the Bluetooth printer.
        // https://developer.android.com/about/versions/12/features/bluetooth-permissions
        if (interfaceType == InterfaceType.Bluetooth) {
            if (!hasBluetoothPermission(applicationContext)) {
                result.error(
                    "no_permission",
                    "You have to allow Nearby devices to use the Bluetooth printer.",
                    null
                )
                return
            }
        }

        try {
            this.manager?.stopDiscovery()

            val interfaceTypes = mutableListOf<InterfaceType>()

            interfaceTypes.add(interfaceType)

            manager = StarDeviceDiscoveryManagerFactory.create(
                interfaceTypes,
                applicationContext
            )
            manager?.discoveryTime = 10000

            manager?.callback = object : StarDeviceDiscoveryManager.Callback {
                override fun onPrinterFound(printer: StarPrinter) {
                    val resultMap: MutableMap<String, Any?> = HashMap()
                    resultMap["model"] = printer.information?.model?.name
                    resultMap["interfaceType"] = printer.connectionSettings.interfaceType.name
                    resultMap["identifier"] = printer.connectionSettings.identifier
                    Log.d("Discovery", "Found printer: ${printer.connectionSettings.identifier}.")
                    result.success(resultMap)
                }

                override fun onDiscoveryFinished() {
                    Log.d("Discovery", "Discovery finished.")
                    result.success(null)
                }
            }

            manager?.startDiscovery()
        } catch (e: Exception) {
            Log.d("Discovery", "Error: $e")
            result.error("discovery_failed", e.message, e.stackTrace.toString())
        }
    }


    private fun getInterfaceType(environment: String?): InterfaceType {
        val type = when (environment) {
            "lan" -> InterfaceType.Lan
            "bluetooth" -> InterfaceType.Bluetooth
            "usb" -> InterfaceType.Usb
            else -> InterfaceType.Unknown
        }
        return type
    }


    companion object {

        private const val requestCode = 1000

        fun hasBluetoothPermission(context: Context): Boolean {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
                return true
            }
            return context.checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) == PackageManager.PERMISSION_GRANTED
        }

        private fun requestBluetoothPermission(context: Context, activity: Activity) {
            if (Build.VERSION.SDK_INT < Build.VERSION_CODES.S) {
                return
            }

            if (context.checkSelfPermission(Manifest.permission.BLUETOOTH_CONNECT) != PackageManager.PERMISSION_GRANTED) {
                activity.requestPermissions(
                    arrayOf(
                        Manifest.permission.BLUETOOTH_CONNECT,
                    ), requestCode
                )
            }
        }
    }
}
