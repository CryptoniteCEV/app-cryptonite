

import Foundation
import UIKit

class Images{
    
    let coins:[String:UIImage]
    
    private init() {
        
        self.coins = ["Bitcoin":#imageLiteral(resourceName: "Bitcoin"), "Ethereum": #imageLiteral(resourceName: "eth"), "Litecoin": #imageLiteral(resourceName: "LITE"), "DogeCoin":#imageLiteral(resourceName: "doge"), "Tether": #imageLiteral(resourceName: "tether")]
    }
    
    static let shared = Images()
    
}
