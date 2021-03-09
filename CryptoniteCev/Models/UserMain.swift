
import Foundation
import UIKit

class UserMain {
    
    private var _profilePic:UIImage
    private var _username:String
    private var _percentage:String?
    
    
    enum CodingKeys: String, CodingKey {
        
        case _profilePic = "profilePic"
        case _user_name = "user_name"
        case _percentage = "percentage"
        
    }
    
    init(profilePic:UIImage, username:String, percentage:String){
        
        self._profilePic = profilePic
        self._username = username
        self._percentage = percentage
    }
    
    public var profilePic: UIImage{
        get{
            return self._profilePic
        }
    }
    
    public var user_name: String {
        get {
            return self._username
        }
    }
    
    public var percentage: String? {
        get {
            return self._percentage
        }
    }
    
}
