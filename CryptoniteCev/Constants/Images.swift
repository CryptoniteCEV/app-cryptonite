

import Foundation
import UIKit

class Images{
    
    let coins:[String:UIImage]
    let users:[UIImage]
    
    private init() {
        
        self.coins = ["Bitcoin":#imageLiteral(resourceName: "Bitcoin"), "Ethereum": #imageLiteral(resourceName: "eth"), "Litecoin": #imageLiteral(resourceName: "LITE"), "DogeCoin":#imageLiteral(resourceName: "doge"), "Tether": #imageLiteral(resourceName: "tether")]
        self.users = [#imageLiteral(resourceName: "user1"), #imageLiteral(resourceName: "user2"), #imageLiteral(resourceName: "user3"), #imageLiteral(resourceName: "user4"), #imageLiteral(resourceName: "user5"), #imageLiteral(resourceName: "user6"), #imageLiteral(resourceName: "user7"), #imageLiteral(resourceName: "user8"), #imageLiteral(resourceName: "user9"), #imageLiteral(resourceName: "user10"), #imageLiteral(resourceName: "user11"), #imageLiteral(resourceName: "user12"), #imageLiteral(resourceName: "user13"), #imageLiteral(resourceName: "user14"), #imageLiteral(resourceName: "user15")]
    }
    
    static let shared = Images()
    
}
