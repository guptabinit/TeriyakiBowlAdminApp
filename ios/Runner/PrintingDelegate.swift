import StarIO10
import UIKit

public class PrintingDelegate : NSObject {
    
    
    public func startPrint(type: InterfaceType, identifier: String, arguments: Dictionary<String, Any>) {
        
        let starConnectionSettings = StarConnectionSettings(interfaceType: type, identifier: identifier)
        
        let printer = StarPrinter(starConnectionSettings)
        
        guard let logo = UIImage(named: "AppLogo") else {
            print("Failed to load \"AppLogo.png\".")
            return
        }
        
        guard let printingData = arguments["printing_data"] as? String else {
            return
        }
        
        let builder = StarXpandCommand.StarXpandCommandBuilder()
        _ = builder.addDocument(StarXpandCommand.DocumentBuilder()
            .addPrinter(StarXpandCommand.PrinterBuilder()
                .styleAlignment(.center)
                .actionPrintImage(StarXpandCommand.Printer.ImageParameter(image: logo, width: 70))
                .actionPrintImage(self.createImageParameterFromText(
                    printingData, size: 20)).actionCut(StarXpandCommand.Printer.CutType.partial)
            )
        )
        
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
    
    
    private  func createImageParameterFromText(_ text: String, size: CGFloat) -> StarXpandCommand.Printer.ImageParameter{
        let width:Int = 560
        let font: UIFont = UIFont(name: "Menlo", size: size)!
        let bitmap = createBitmapFromText(text, font: font, width: width)
        return StarXpandCommand.Printer.ImageParameter(image:bitmap, width:width)
    }
    
    
    private func createBitmapFromText(_ text: String, font: UIFont, width:Int) -> UIImage {
        let attributeDic: NSDictionary = NSDictionary(dictionary: [NSAttributedString.Key.font : font])
        let widthCGF: CGFloat = CGFloat(width);
        let stringDrawingOptions: NSStringDrawingOptions = [NSStringDrawingOptions.usesLineFragmentOrigin, NSStringDrawingOptions.truncatesLastVisibleLine]
        
        let size: CGSize = (text.boundingRect(with: CGSize(width: widthCGF, height: 10000), options: stringDrawingOptions, attributes: attributeDic as? [NSAttributedString.Key : Any], context: nil)).size
        
        if UIScreen.main.responds(to: #selector(NSDecimalNumberBehaviors.scale)) {
            if UIScreen.main.scale == 2.0 {
                UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
            } else {
                UIGraphicsBeginImageContext(size)
            }
        } else {
            UIGraphicsBeginImageContext(size)
        }
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        
        UIColor.white.set()
        
        let rect: CGRect = CGRect(x: 0, y: 0, width: size.width + 1, height: size.height + 1)
        
        context.fill(rect)
        
        let attributes: NSDictionary = NSDictionary(dictionary: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : font])
        
        text.draw(in: rect, withAttributes: attributes as? [NSAttributedString.Key : Any])
        
        let imageToPrint: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return imageToPrint
    }
    
}
