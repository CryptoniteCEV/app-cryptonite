
import Foundation;
import UIKit;

class Trade {
    
    private let _coin:String
    private let _date:String
    private let _quantity:Double
    private let _price:Double
    private let _isSell:Int
    
    init(coin:String, date: String, quantity:Double, price:Double, isSell:Int){
        self._coin = coin
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
    
    public var quantity: Double {
        get {
            return self._quantity;
        }
    }
    
    public var price: Double {
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
