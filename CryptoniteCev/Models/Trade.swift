
import Foundation;
import UIKit;

class Trade {
    
    private let _profilePic:UIImage
    private let _username:String
    private let _quantity:Int
    private let _idCoin:Int
    
    init(profilePic:UIImage,username:String, idCoin:Int, quantity:Int){
        self._profilePic = profilePic
        self._username = username
        self._idCoin = idCoin
        self._quantity = quantity
    }
    
    public var profilePic: UIImage {
        get {
            return self._profilePic;
        }
    }
    public var username:  String {
        get {
            return self._username;
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
