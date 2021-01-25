
import Foundation;
import UIKit;

class Wallet : Decodable, Encodable{
    
    private var _idsCoin:[Int]
    private var _quantities:[Int]
    private var _dollars:Float
    
    init(idsCoins:[Int], quantities:[Int], dollars:Float){
        self._idsCoin = idsCoins
        self._quantities = quantities
        self._dollars = dollars
    }
    
    public var coins: [Int] {
        get {
            return self._idsCoin;
        }
        set {
            self._idsCoin = newValue
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
