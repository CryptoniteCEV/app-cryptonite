
import Foundation
import UIKit

class UserPrueba {
    
    private var _profilePic:UIImage
    private var _user_name:String
    private var _percentage:String
    
    
    enum CodingKeys: String, CodingKey {
        
        case _profilePic = "profilePic"
        case _user_name = "user_name"
        case _percentage = "percentage"
        
    }
    
    init(profilePic:UIImage, user_name:String, percentage:String){
        
        self._profilePic = profilePic
        self._user_name = user_name
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
    
    public var percentage: String {
        get {
            return self._percentage
        }
    }
    
}
