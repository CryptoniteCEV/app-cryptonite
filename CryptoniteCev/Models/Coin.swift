

import Foundation;
import UIKit;

class Coin : Decodable, Encodable{
    
    private var _name:String
    private var _symbol:String
    private var _price:Double?
    
    init(name:String, symbol:String){
        self._name = name
        self._symbol = symbol
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
    
    public var price: Double {
        get {
            return self._price!;
        }
        set {
            self._price = newValue
        }
    }
    
}
