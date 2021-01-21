
import Foundation;
import UIKit;

class User : Encodable, Decodable{
    
    private let _username:String
    private let _email:String
    private var _name:String
    private var _surname:String
    private let _dateOfBirth:Date
    private var _profilePic:String

    
    init(username:String, email:String, name:String, surname:String, dateOfBirth:Date, profilePic:String){
        
        self._username = username
        self._email = email
        self._name = name
        self._surname = surname
        self._dateOfBirth = dateOfBirth
        self._profilePic = profilePic
    }
    
    /**
     Devuelve info del usuario orientada a ser mostrada en el perfil
     */
    public func getProfileInfo()->[String:Any]{
        return ["username":_username,"email":_email,"name":_name,"surname":_surname,"dateOfBirth":_dateOfBirth]
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
    public var surname: String {
        get {
            return self._surname;
        }
        set {
            self._surname = newValue
        }
    }
    
    public var dateOfBirth: Date {
        get {
            return self._dateOfBirth;
        }
    }
    
    public var profilePic: String {
        get {
            return self._profilePic;
        }
        set {
            self._profilePic = newValue
        }
    }
    
}
