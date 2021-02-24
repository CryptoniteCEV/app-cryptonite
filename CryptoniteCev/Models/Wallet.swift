
import Foundation;
import UIKit;

class Wallet {
    private var icon: UIImage
    private var _idsCoin:String
    private var _simbol:String
    private var _quantities:Int
    private var _dollars:Float
    
    init(icon : UIImage, idsCoins:String,simbol:String, quantities:Int, dollars:Float){
        
        self.icon = icon
        self._idsCoin = idsCoins
        self._simbol = simbol
        self._quantities = quantities
        self._dollars = dollars
    }
    
    public var icons: UIImage {
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
    
    public var simbol: String {
        get {
            return self._simbol;
        }
        set {
            self._simbol = newValue
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
