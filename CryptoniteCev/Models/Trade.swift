
import Foundation;
import UIKit;

class Trade {
    
    private let _profilePic:UIImage
    private let _quantity:Int
    private let _idCoin:Int
    
    init(profilePic:UIImage, idCoin:Int, quantity:Int){
        self._profilePic = profilePic
        self._idCoin = idCoin
        self._quantity = quantity
    }
    
    public var profilePic: UIImage {
        get {
            return self._profilePic;
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
