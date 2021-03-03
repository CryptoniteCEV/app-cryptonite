
import Foundation;
import UIKit;

class Trade {
    
    private let _profilePic:UIImage
    private let _username:String
    private let _price:Double
    private let _quantity:Double
    private let _currencyIcon: UIImage
    
    init(profilePic:UIImage,username:String,price:Double ,currencyIcon:UIImage, quantity:Double){
        self._profilePic = profilePic
        self._username = username
        self._price = price
        self._currencyIcon = currencyIcon
        self._quantity = quantity
    }
    
    public var profilePic: UIImage {
        get {
            return self._profilePic;
        }
    }
    
    public var price: Double {
        get {
            return self._price;
        }
    }
    
    public var username:  String {
        get {
            return self._username;
        }
    }
    public var quantity: Double {
        get {
            return self._quantity;
        }
    }
    public var currencyIcon:UIImage {
        get {
            return self._currencyIcon;
        }
    }
    
}
