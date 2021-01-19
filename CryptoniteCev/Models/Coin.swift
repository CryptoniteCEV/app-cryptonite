

import Foundation;
import UIKit;

class Coin{
    
    private var _name:String
    private var _price:Int
    
    init(name:String, price:Int){
        self._name = name
        self._price = price
    }
    
    public var name: String {
        get {
            return self._name;
        }
        set {
            self._name = newValue
        }
    }
    
    public var price: Int {
        get {
            return self._price;
        }
        set {
            self._price = newValue
        }
    }
    
}
