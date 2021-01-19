
import Foundation;
import UIKit;

class Wallet{
    
    private var _coins:[Coin]
    private var _quantities:[Int]
    
    init(coins:[Coin], quantities:[Int]){
        self._coins = coins
        self._quantities = quantities
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
}
