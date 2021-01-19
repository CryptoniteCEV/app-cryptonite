
import Foundation;
import UIKit;

class User{
    
    private let _username:String
    private let _email:String
    private var _name:String
    private var _surname:String
    private let _dateOfBirth:Date
    private var _profilePic:UIImage
    
    private let _wallet:Wallet
    
    private var _followers:[User]
    private var _followings:[User]
    
    private let _score:Score

    
    init(username:String, email:String, name:String, surname:String, dateOfBirth:Date, profilePic:UIImage, wallet: Wallet, score:Score){
        
        self._username = username
        self._email = email
        self._name = name
        self._surname = surname
        self._dateOfBirth = dateOfBirth
        self._profilePic = profilePic
        self._wallet = wallet
        self._followers = []
        self._followings = []
        self._score = score
    }
    
    
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
    
    public var profilePic: UIImage {
        get {
            return self._profilePic;
        }
        set {
            self._profilePic = newValue
        }
    }
    
    public var wallet: Wallet {
        get {
            return self._wallet;
        }
    }
    
    public var followers: [User] {
        get {
            return self._followers;
        }
        set{
            self._followers = newValue;
        }
    }
    
    public var following: [User] {
        get {
            return self._followings;
        }
        set{
            self._followings = newValue;
        }
    }
    
    public var score: Score {
        get {
            return self._score;
        }
    }
    
}
