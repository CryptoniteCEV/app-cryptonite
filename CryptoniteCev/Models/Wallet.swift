
import Foundation;
import UIKit;

class Wallet {
    private var _coin:String
    private var _symbol:String
    private var _quantity:Double
    private var _inDollars:Double
    
    init(coin:String, symbol:String, quantity:Double, inDollars:Double){
        
        self._coin = coin
        self._symbol = symbol
        self._quantity = (round(1000*quantity)/1000)
        self._inDollars = (round(1000*inDollars)/1000)
    }
    
    public var coin: String {
        get {
            return self._coin;
        }
        set {
            self._coin = newValue
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
