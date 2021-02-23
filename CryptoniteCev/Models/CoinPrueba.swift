
import Foundation
import UIKit

class CoinPrueba : Encodable, Decodable{
    
     private var _icon:String
     private var _coin_name:String
     private var _category:String
     private var _ammount:String
     private var _percentage:String
    
    enum CodingKeys:String, CodingKey {
        case _icon = "icon"
        case _coin_name = "coin_name"
        case _category = "category"
        case _ammount = "ammount"
        case _percentage = "percentage"
        
    }
    
    init(icon:String, coin_name:String, category:String, ammount:String, percentage:String){
        
        self._icon = icon
        self._coin_name = coin_name
        self._category = category
        self._ammount = ammount
        self._percentage = percentage
    }
    
    public var icon: String {
        get {
            return self._icon
        }
    }
    public var coin_name: String {
        get {
            return self._coin_name
        }
    }
    public var category: String {
        get {
            return self._category
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
