
import Foundation;
import UIKit;

class TradeHistory : Decodable, Encodable{
    
    private var _coinFrom:String
    private var _coinTo:String
    private var _coinFromSymbol:String
    private var _coinToSymbol:String
    private var _quantity:Double
    private var _username:String
    private var _converted:Double
    
    init(coinFrom:String, coinTo:String, coinFromSymbol:String, coinToSymbol:String ,quantity:Double, username:String, converted:Double){
        
        self._coinFrom = coinFrom
        self._coinTo = coinTo
        self._coinFromSymbol = coinFromSymbol
        self._coinToSymbol = coinToSymbol
        self._quantity = quantity
        self._username = username
        self._converted = converted
        
    }
    
    public var coinFrom: String {
        get {
            return self._coinFrom;
        }
        set {
            self._coinFrom = newValue
        }
    }
    public var coinTo: String {
        get {
            return self._coinTo;
        }
        set {
            self._coinTo = newValue
        }
    }
    public var coinFromSymbol: String {
        get {
            return self._coinFromSymbol;
        }
        set {
            self._coinFromSymbol = newValue
        }
    }
    public var coinToSymbol: String {
        get {
            return self._coinToSymbol;
        }
        set {
            self._coinToSymbol = newValue
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
    
    public var converted: Double {
        get {
            return self._converted;
        }
        set {
            self._converted = newValue
        }
    }
    
    public var username: String {
        get {
            return self._username;
        }
        set {
            self._username = newValue
        }
    }
}
