//import StarIO10
//
//public class PrintingDelegate : NSObject {
//     
//     
//     public func startPrint(type: InterfaceType, identifier: String, arguments: Dictionary<String, Any>) {
//          
//          let starConnectionSettings = StarConnectionSettings(interfaceType: type,
//                                                              identifier: identifier)
//          
//          let printer = StarPrinter(starConnectionSettings)
//          
//          let builder = StarXpandCommand.StarXpandCommandBuilder()
//          
//          let printerBuilder = StarXpandCommand.PrinterBuilder()
//          
//          if let logo = UIImage(named: "AppLogo")  {
//               printerBuilder.actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 300))
//                    .styleInternationalCharacter(.usa).styleAlignment(.left)
//          }
//          
//          if let placedAtDate = arguments["placedAtDate"] as? String {
//               printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(false).styleAlignment(.left).actionPrintText("\n\(placedAtDate)"))
//          }
//          
//          if let customerName = arguments["customerName"] as? String {
//               printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).styleAlignment(.left).actionPrintText("\(customerName)\n"))
//          }
//          
//          if let holeNumber = arguments["holeNumber"] as? String {
//               printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).styleMagnification(StarXpandCommand.MagnificationParameter(width: 3, height: 2)).styleInvert(true).actionPrintText("\n\(holeNumber)"))
//          }
//          
//          if let foodAllergy = arguments["foodAllergy"] as? String {
//               printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).styleAlignment(.left).actionPrintText("\n\(foodAllergy)"))
//          }
//          
//          printerBuilder.add(StarXpandCommand.PrinterBuilder().actionPrintText("\n------------------------------------------------\n\n")).add(StarXpandCommand.PrinterBuilder().styleMagnification(StarXpandCommand.MagnificationParameter(width: 2, height: 2)).styleAlignment(.center).actionPrintText("DELIVERY\n\n"))
//          
//          if let items = arguments["items"] as? [[String: Any]] {
//               for item in items {
//                    if let item = item["item"] as? String {
//                         printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(true).styleAlignment(.left).actionPrintText(item))
//                         
//                    }
//                    
//                    if let modifiers = item["modifiers"] as? String, !modifiers.isEmpty {
//                         printerBuilder.add(StarXpandCommand.PrinterBuilder().styleBold(false).styleAlignment(.left).actionPrintText(modifiers))
//                         
//                    }
//               }
//          }
//          
//          printerBuilder.actionPrintText("------------------------------------------------\n").styleAlignment(.center)
//          
//          if let thankYouMessage = arguments["thankYouMessage"] as? String {
//               printerBuilder.add(StarXpandCommand.PrinterBuilder().actionPrintText("\(thankYouMessage)\n\n"))
//                    .actionCut(StarXpandCommand.Printer.CutType.partial)
//          }
//          
//          _ = builder.addDocument(StarXpandCommand.DocumentBuilder().addPrinter(printerBuilder))
//          
//        
//          
//          let command = builder.getCommands()
//          
//          Task {
//               do {
//                    try await printer.open()
//                    defer {
//                         Task {
//                              await printer.close()
//                         }
//                    }
//                    
//                    try await printer.print(command: command)
//                    
//                    print("Success")
//               } catch let error {
//                    print("Error: \(error)")
//               }
//          }
//     }
//     
//}
