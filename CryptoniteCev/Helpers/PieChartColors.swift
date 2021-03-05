import Foundation
import CoreGraphics

open class PieChartColors: NSObject
{
    
    @objc open class func currencies () -> [NSUIColor]
    {
        return [
            NSUIColor(red: 242/255.0, green: 127/255.0, blue: 27/255.0, alpha: 0.95),
            NSUIColor(red: 148/255.0, green: 212/255.0, blue: 212/255.0, alpha: 1.0),
            NSUIColor(red: 136/255.0, green: 180/255.0, blue: 187/255.0, alpha: 1.0),
            NSUIColor(red: 118/255.0, green: 174/255.0, blue: 175/255.0, alpha: 1.0),
            NSUIColor(red: 42/255.0, green: 109/255.0, blue: 130/255.0, alpha: 1.0)
        ]
    }

}
