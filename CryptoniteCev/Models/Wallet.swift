
import Foundation;
import UIKit;

class Wallet : Decodable{
    
    private var _coins:[Coin]
    private var _quantities:[Int]
    private var _dollars:Float
    
    init(coins:[Coin], quantities:[Int], dollars:Float){
        self._coins = coins
        self._quantities = quantities
        self._dollars = dollars
    }
    
    public var coins: [Coin] {
        get {
            return self._coins;
        }
        set {
            self._coins = newValue
        }
    }
    public var quantities: [Int] {
        get {
            return self._quantities;
        }
        set {
            self._quantities = newValue
        }
    }
    
    public var dollars: Float {
        get {
            return self._dollars;
        }
        set {
            self._dollars = newValue
        }
    }
}
