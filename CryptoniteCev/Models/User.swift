
import Foundation;
import UIKit;

class User : Encodable, Decodable{
    
     private var _username:String
     private var _email:String
     private var _name:String
     private var _surname:String
     private var _dateOfBirth:String
     private var _profilePic:String?
     private var _password:String
    
    enum CodingKeys:String, CodingKey {
        case _name = "name"
        case _username = "username"
        case _profilePic = "profile_pic"
        case _email = "email"
        case _surname = "surname"
        case _password = "password"
        case _dateOfBirth = "dateOfBirth"
    }
    
    init(username:String, email:String, name:String, surname:String, profilePic:String, password:String, dateOfBirth:String){
        
        self._username = username
        self._email = email
        self._name = name
        self._surname = surname
        self._profilePic = profilePic
        self._password = password
        self._dateOfBirth = dateOfBirth
    }
    
    /**
     Devuelve info del usuario orientada a ser mostrada en el perfil
     */
    /*public func getProfileInfo()->[String:Any]{
        return ["username":_username,"email":_email,"name":_name,"surname":_surname,"dateOfBirth":_dateOfBirth]
    }*/
    
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
    public var surname: String {
        get {
            return self._surname;
        }
        set {
            self._surname = newValue
        }
    }
    
    public var profilePic: String {
        get {
            return self._profilePic!;
        }
        set {
            self._profilePic = newValue
        }
    }
    
}
