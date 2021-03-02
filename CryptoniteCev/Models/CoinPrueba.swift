
import Foundation
import UIKit

class CoinPrueba {
    
     private var _icono:UIImage
     private var _coin_name:String
     private var _ammount:String
     private var _percentage:String
    
    enum CodingKeys: String, CodingKey {
        case _icono = "icono"
        case _coin_name = "coin_name"
        case _ammount = "ammount"
        case _percentage = "percentage"
        
    }
    
    init(icono:UIImage, coin_name:String, ammount:String, percentage:String){
        
        self._icono = icono
        self._coin_name = coin_name
        self._ammount = ammount
        self._percentage = percentage
    }
    
    public var icono: UIImage {
        get {
            return self._icono
        }
    }
    public var coin_name: String {
        get {
            return self._coin_name
        }
    }

    public var ammount: String {
        get {
            return self._ammount
        }
    }
    public var percentage: String {
        get {
            return self._percentage
        }
    }
    
}
