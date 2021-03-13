
import Foundation;
import UIKit;

class User : Encodable, Decodable{
    
    private var _username:String
    private var _email:String
    private var _name:String
    private var _profilePic:Int
    private var _password:String
    
    enum CodingKeys:String, CodingKey {
        case _name = "name"
        case _username = "username"
        case _email = "email"
        case _password = "password"
        case _profilePic = "profile_pic"
    }
    
    init(username:String, email:String, name:String, password:String, profilePic:Int){
        
        self._username = username
        self._email = email
        self._name = name
        self._password = password
        self._profilePic = profilePic
    }
    
    public var name: String {
        get {
            return self._name;
        }
        set {
            self._name = newValue
        }
    }
    
    public var username: String {
        get {
            return self._username;
        }
    }
    public var email: String {
        get {
            return self._email;
        }
    }
    
    public var profilePic: Int {
        get {
            return self._profilePic;
        }
        set {
            self._profilePic = newValue
        }
    }

    
}
