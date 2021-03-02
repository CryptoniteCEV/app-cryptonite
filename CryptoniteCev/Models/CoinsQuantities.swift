

import Foundation;
import UIKit;

class CoinsQuantities : Decodable, Encodable{
    
    private var _name:String
    private var _symbol:String
    private var _quantity:Double
    private var _inDollars:Double
    
    init(name:String, symbol:String, quantity:Double, inDollars:Double){
        self._name = name
        self._symbol = symbol
        self._quantity = quantity
        self._inDollars = inDollars
    }
    
    public var name: String {
        get {
            return self._name;
        }
        set {
            self._name = newValue
        }
    }
    public var symbol: String {
        get {
            return self._symbol;
        }
        set {
            self._symbol = newValue
        }
    }
    
    public var quantity: Double {
        get {
            return self._quantity;
        }
        set {
            self._quantity = newValue
        }
    }
    
    public var inDollars: Double {
        get {
            return self._inDollars;
        }
        set {
            self._inDollars = newValue
        }
    }
    
}
