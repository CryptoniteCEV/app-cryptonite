import Foundation
import UIKit

class UserStories {
    
    private var _profilePic:UIImage
    private var _username:String
    
    enum CodingKeys: String, CodingKey {
        
        case _profilePic = "profilePic"
        case _username = "username"
        
    }
    
    init(profilePic:UIImage, username:String){
        
        self._profilePic = profilePic
        self._username = username
    }
    
    public var profilePic: UIImage{
        get{
            return self._profilePic
        }
    }
    
    public var username: String {
        get {
            return self._username
        }
    }
    
}

