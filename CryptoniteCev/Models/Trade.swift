
import Foundation;
import UIKit;

class Trade : Decodable, Encodable{
    
    private let _id:String
    private let _quantity:Int
    private let _idCoin:Int
    
    init(id:String, idCoin:Int, quantity:Int){
        self._id = id
        self._idCoin = idCoin
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
    public var coins: Int {
        get {
            return self._idCoin;
        }
    }
    
}
