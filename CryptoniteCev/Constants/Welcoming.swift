import Foundation
import UIKit

class Welcomings{
    
    let phrases:[String]
    
    private init() {
        
        //Frases que apareceran en login de forma aleatoria
        self.phrases = ["Jealous of Bruce Wayne? \n Let’s go to the mooooon!",
                        "Jeff Bezos? Who?",
                        "HOOOOOOODL!",
                        "Buy the dip, sell the rip",
                        "What are you buying today?",
                        "Are you a paper or a diamond hand?",
                        "Dogecoin is my kryptonite"]
    }
    
    static let shared = Welcomings()
    
}
