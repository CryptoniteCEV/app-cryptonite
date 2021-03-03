import Foundation
import UIKit

class Welcomings{
    
    let phrases:[String]
    
    private init() {
        
        self.phrases = ["Jealous of Bruce Wayne? Let’s go to the mooooon!", "Jeff Bezos? Who?", "HOOOOOOODL!", "Buy the dip, sell the rip", "What are you buying today?", "Are you a paper or a diamond hand?", "Dogecoin is my kryptonite"]
    }
    
    static let shared = Welcomings()
    
}
