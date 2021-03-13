
import Foundation
import UIKit

class UserMain {
    
    private var _profilePic:UIImage
    private var _username:String
    private var _experience:Double
    
    
    enum CodingKeys: String, CodingKey {
        
        case _profilePic = "profilePic"
        case _username = "username"
        case _experience = "experience"
        
    }
    
    init(profilePic:UIImage, username:String, experience:Double){
        
        self._profilePic = profilePic
        self._username = username
        self._experience = experience
    }
    
    public var profilePic: UIImage{
        set {
            self._profilePic = newValue
        }
        get{
            return self._profilePic
        }
    }
    
    public var username: String {
        set {
            self._username = newValue
        }
        get {
            return self._username
        }
    }
    
    public var experience: Double {
        set {
            self._experience = newValue
        }
        get {
            return self._experience
        }
    }
    
}
