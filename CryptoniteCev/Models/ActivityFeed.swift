
import UIKit
import Foundation

class ActivityFeed {
    
    private var _profilePic:UIImage
    private var _user_name:String
    private var _coin_selling:String
    private var _icon_selling:UIImage
    private var _coin_buying:String
    private var _icon_buying:UIImage
    
    enum CodingKeys: String, CodingKey {
        case _profilePic = "profilePic"
        case _user_name = "user_name"
        case _coin_selling = "coin_selling"
        case _icon_selling = "icon_selling"
        case _coin_buying = "coin_buying"
        case _icon_buying = "icon_buying"
        
    }
    
    init(profilePic:UIImage, user_name:String, coin_selling:String, icon_selling:UIImage, coin_buying:String, icon_buying:UIImage){
        
        self._profilePic = profilePic
        self._user_name = user_name
        self._coin_selling = coin_selling
        self._icon_selling = icon_selling
        self._coin_buying = coin_buying
        self._icon_buying = icon_buying
    }
    
    public var profilePic: UIImage{
        get{
            return self._profilePic
        }
    }
    
    public var user_name: String {
        get {
            return self._user_name
        }
    }
    
    public var coin_selling: String {
        get {
            return self._coin_selling
        }
    }
    public var icon_selling: UIImage {
        get {
            return self._icon_selling
        }
    }
    public var coin_buying: String {
        get {
            return self._coin_buying
        }
    }
    public var icon_buying: UIImage {
        get {
            return self._icon_buying
        }
    }
    
}
