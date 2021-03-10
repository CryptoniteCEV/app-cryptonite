import Foundation
import Charts

class Colors{
    
    let graph:[String:NSUIColor]
    
    private init() {
        
        self.graph = [
            "ETH":NSUIColor(red: 98/255.0, green: 126/255.0, blue: 224/255.0, alpha: 0.95),
            "BTC":NSUIColor(red: 242/255.0, green: 127/255.0, blue: 27/255.0, alpha: 0.95),
            "DOGE":NSUIColor(red: 244/255.0, green: 245/255.0, blue: 121/255.0, alpha: 0.96),
            "LTC":NSUIColor(red: 192/255.0, green: 192/255.0, blue: 192/255.0, alpha: 0.75),
            "USDT":NSUIColor(red: 80/255.0, green: 175/255.0, blue: 149/255.0, alpha: 0.69)
        ]
    }
    
    static let shared = Colors()
    
}
