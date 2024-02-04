import UIKit
import Flutter
import StarIO10

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, StarDeviceDiscoveryManagerDelegate {
    
    private var manager: StarDeviceDiscoveryManager? = nil
    private var result: FlutterResult? = nil
    private var printingDelegate = PrintingDelegate()
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        
        let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: "com.teriyaki-bowl/star-io10",
                                           binaryMessenger: controller.binaryMessenger)
        
        channel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            self.result = result
            
            if call.method == "startDiscovery" {
                self.manager?.stopDiscovery()
                
                if let arguments = call.arguments as? Dictionary<String, Any> {
                    let interfaceType = arguments["interfaceType"] as? String ?? "unknown"
                    
                    var interfaceTypeArray : [InterfaceType] = []
                    
                    interfaceTypeArray.append(self.getInterfaceType(type: interfaceType))
                    
                    do {
                        try self.manager = StarDeviceDiscoveryManagerFactory.create(interfaceTypes: interfaceTypeArray)
                        
                        self.manager?.discoveryTime = 10000
                        
                        self.manager?.delegate = self
                        
                        try self.manager?.startDiscovery()
                        
                    } catch let error {
                        result(FlutterError(code: "discovery_failed", message: error.localizedDescription, details: nil))
                    }
                }
                
                
                
            } else if call.method == "print" {
                
                if let arguments = call.arguments as? Dictionary<String, Any>{
                    let identifier = arguments["identifier"] as! String
                    let interfaceType = arguments["interfaceType"] as? String ?? "unknown"
                    
                    let type = self.getInterfaceType(type: interfaceType)
                    
                    self.printingDelegate.startPrint(type: type, identifier: identifier, arguments: arguments)
                }
                
            } else {
                result(FlutterMethodNotImplemented)
            }
            
        })
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func managerDidFinishDiscovery(_ manager: StarDeviceDiscoveryManager) {
        print("Discovery finished.")
        self.manager = nil
        self.result?(FlutterError(code: "discovery_finished", message: "Discovery finished.", details: nil))
    }
    
    func manager(_ manager: StarDeviceDiscoveryManager, didFind printer: StarPrinter) {
        if self.result != nil {
            var resultMap = [String : Any]()
            
            if let model = printer.information?.model.description {
                resultMap["model"] = model
            }
            
            switch printer.connectionSettings.interfaceType {
            case .lan:
                resultMap["interfaceType"] = "lan"
                
            case .bluetooth:
                resultMap["interfaceType"] = "bluetooth"
                
            case .bluetoothLE:
                resultMap["interfaceType"] = "bluetoothLE"
                
            case .usb:
                resultMap["interfaceType"] = "usb"
                
            default:
                resultMap["interfaceType"] = "unknown"
                break
            }
            resultMap["identifier"] = printer.connectionSettings.identifier
            
            self.result?(resultMap)
        }
    }
    
    func getInterfaceType(type: String) -> InterfaceType {
        var interfaceType: InterfaceType = .unknown
        
        switch type {
        case "lan":
            interfaceType = .lan
        case "bluetooth":
            interfaceType = .bluetooth
        case "bluetoothLE":
            interfaceType = .bluetoothLE
        case "usb":
            interfaceType = .usb
        default:
            interfaceType = .unknown
        }
        return interfaceType
    }
}


