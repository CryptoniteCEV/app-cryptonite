
import Foundation;
import UIKit;

class Trade : Decodable{
    
    private let _id:String
    private let _quantity:Int
    private let _coin:Coin
    
    init(id:String, coin:Coin, quantity:Int){
        self._id = id
        self._coin = coin
        self._quantity = quantity
    }
    
    public var id: String {
        get {
            return self._id;
        }
    }
    public var quantity: Int {
        get {
            return self._quantity;
        }
    }
    public var coins: Coin {
        get {
            return self._coin;
        }
    }
    
}
