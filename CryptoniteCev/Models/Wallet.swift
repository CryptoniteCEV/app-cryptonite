
import Foundation;
import UIKit;

class Wallet : Decodable, Encodable{
    private var icon: String
    private var _idsCoin:String
    private var _quantities:Int
    private var _dollars:Float
    
    init(icon : String, idsCoins:String, quantities:Int, dollars:Float){
        
        self.icon = icon
        self._idsCoin = idsCoins
        self._quantities = quantities
        self._dollars = dollars
    }
    
    public var icons:String {
        get {
            return self.icon;
        }
        set {
            self.icon = newValue
        }
    }
    
    public var coins: String {
        get {
            return self._idsCoin;
        }
        set {
            self._idsCoin = newValue
        }
    }
    public var quantities: Int {
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
