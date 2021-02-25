
import Foundation
import UIKit

class UserPrueba {
    
    private var _profilePic:UIImage
    private var _user_name:String
    private var _name:String
    private var _category:String
    private var _percentage:String
    
    enum CodingKeys: String, CodingKey {
        case _profilePic = "profilePic"
        case _user_name = "user_name"
        case _name = "name"
        case _category = "category"
        case _percentage = "percentage"
        
    }
    
    init(profilePic:UIImage, user_name:String, name:String, category:String, percentage:String){
        
        self._profilePic = profilePic
        self._user_name = user_name
        self._name = name
        self._category = category
        self._percentage = percentage
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
    public var name: String {
        get {
            return self._name
        }
    }
    
    public var category: String {
        get {
            return self._category
        }
    }
    
    public var percentage: String {
        get {
            return self._percentage
        }
    }
    
}
