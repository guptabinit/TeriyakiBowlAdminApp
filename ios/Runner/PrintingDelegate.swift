import StarIO10
import UIKit

public class PrintingDelegate : NSObject {
    
    
    public func startPrint(type: InterfaceType, identifier: String, arguments: Dictionary<String, Any>) {
        
        let starConnectionSettings = StarConnectionSettings(interfaceType: type,
                                                            identifier: identifier)
        
        let printer = StarPrinter(starConnectionSettings)
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        
        let printerBuilder = StarXpandCommand.PrinterBuilder()
        
        if let logo = UIImage(named: "AppLogo")  {
            printerBuilder.actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 120))
                .styleInternationalCharacter(.usa).styleAlignment(.left)
        }
        
        printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2)).actionPrintText("\nTeriyaki Bowl"))
        
        
        printerBuilder.add(StarXpandCommand.PrinterBuilder().actionPrintText("\n------------------------------------------"))
        
        
        printerBuilder.add(
            StarXpandCommand.PrinterBuilder().styleAlignment(.left).actionPrintText("Customer Name")
        )
        
        if let customerName = arguments["customer_name"] as? String {
            printerBuilder.add(StarXpandCommand.PrinterBuilder().styleAlignment(.left).styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2)).actionPrintText(customerName))
        }
        
        
        printerBuilder.add(
            StarXpandCommand.PrinterBuilder().styleAlignment(.left).actionPrintText("Pickup Time")
        )
        
        if let pickupTime = arguments["pickup_time"] as? String {
            printerBuilder.add(StarXpandCommand.PrinterBuilder().styleAlignment(.left).styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2)).actionPrintText(pickupTime))
        }
        
        
        printerBuilder.add(
            StarXpandCommand.PrinterBuilder().styleAlignment(.left).actionPrintText("Order Number")
        )
        
        if let orderNumber = arguments["order_number"] as? String {
            printerBuilder.add(StarXpandCommand.PrinterBuilder().styleAlignment(.left).styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2)).actionPrintText(orderNumber))
        }
        
        
        printerBuilder.add(
            StarXpandCommand.PrinterBuilder().styleAlignment(.left).actionPrintText("Total Items")
        )
        
        if let totalItems = arguments["total_items"] as? String {
            printerBuilder.add(StarXpandCommand.PrinterBuilder().styleAlignment(.left).styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2)).actionPrintText(totalItems))
            
            
        }
        
        printerBuilder.add(StarXpandCommand.PrinterBuilder().actionPrintText("------------------------------------------"))
        
        
        if let items = arguments["items"] as? [[String: Any]] {
            for item in items {
                if let item = item["item"] as? String {
                    printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).styleAlignment(.left).actionPrintText(item))
                    
                }
                
                if let modifiers = item["modifiers"] as? String, !modifiers.isEmpty {
                    printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(false).styleAlignment(.left).actionPrintText(modifiers))
                    
                }
            }
        }
        
        
        let subTotal = arguments["sub_total"] as? String
        let tax = arguments["tax"] as? String
        
        if subTotal != nil && tax != nil {
            printerBuilder.add(
                StarXpandCommand.PrinterBuilder().actionPrintText(subTotal!).actionPrintText(tax!)
            )
        }
        
        if let total = arguments["total"] as? String {
            printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).actionPrintText(total))
        }
        
        printerBuilder.add(StarXpandCommand.PrinterBuilder()
            .actionCut(StarXpandCommand.Printer.CutType.partial))
        
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder().addPrinter(printerBuilder))
        
        
        
        let command = builder.getCommands()
        
        Task {
            do {
                try await printer.open()
                defer {
                    Task {
                        await printer.close()
                    }
                }
                
                try await printer.print(command: command)
                
                print("Success")
            } catch let error {
                print("Error: \(error)")
            }
        }
    }
    
}
