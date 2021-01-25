import Foundation

class Endpoints {
    
    private init() {}
    
    let shared = Endpoints()
    
    static let baseUrl = "http://192.168.1.40/Laravel/api-cryptonite/public/api/users"
    
    //User´s Petitions
    enum User {
        static let register:String = "/register"
        static let login:String = "/login"
        static let restorePassword:String = "/generateNewPassword"
        static let updatePassword:String = "/updatePassword"
        static let getProfileInfo:String = "/getProfileInfo"
        static let updateProfile:String = "/updateProfile"
        static let getFollowerInfo:String = "/getFollowerInfo"
        static let followUser:String = "/followUser"
        static let getFollowings:String = "/getFollowings"
        static let updateExperience:String = "/updateExperience"
        static let updateLevel:String = "/updateLevel"
        static let getFollowers:String = "/getFollowers"
        static let trade:String = "/tradeCoin"
        static let all:String = "/all"
    }
    //Score´s petitions
    enum Score {
        static let getScores:String = "/getScores"
    }

    //Trading´s petitions
    enum Trading{
        static let getTradingHistory:String = "/deposit"
    }

    //Deposit´s petitions
    enum Wallet{
        static let getWalletInfo:String = "/getWalletInfo"
        static let deposit:String = "/deposit"
    }
        
    //Currency´s petitions
    enum Coin{
        static let getCoinsList:String = "/getCoinList"
        static let setNewCurrency:String = "/setNewCurrency"
    }
}

    
    


