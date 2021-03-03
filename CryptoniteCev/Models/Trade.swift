
import Foundation;
import UIKit;

class Trade : Decodable, Encodable{
    
    private let _coin:String
    private let _date:String
    private let _quantity:Int
    private let _price:Int
    private let _isSell:Int
    
    
    
    init(idCoin:String, date: String, quantity:Int, price:Int, isSell:Int){
        self._coin = idCoin
        self._date = date
        self._quantity = quantity
        self._price = price
        self._isSell = isSell
    }
    
    public var coin: String {
        get {
            return self._coin;
        }
    }
    
    public var date: String {
        get {
            return self._date;
        }
    }
    
    public var quantity: Int {
        get {
            return self._quantity;
        }
    }
    
    public var price: Int {
        get {
            return self._price;
        }
    }
    
    public var isSell: Int {
        get {
            return self._isSell;
        }
    }
    
    
}
