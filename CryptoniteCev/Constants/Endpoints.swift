import Foundation

class Endpoints {
    
    private init() {}
    
    let shared = Endpoints()
    
    static let domain = ""// "http://54.209.231.136"
    static let path = "/api-cryptonite/public/api"
    
    //User´s Petitions
    enum User {
        static let register:String = "/users/register"
        static let login:String = "/users/login"
        static let restorePassword:String = "/users/restore/password"
        static let updatePassword:String = "/users/update/password"
        static let getProfileInfo:String = "/users/profile/info"
        static let updateProfile:String = "/users/update"
        static let followUser:String = "/users/follow"
        static let getFollowings:String = "/users/followings/list"
        static let updateExperience:String = "/users/update/exp"
        static let getFollowers:String = "/users/followers/list"
        static let trade:String = "/users/trade/coin"
        static let all:String = "/users/all"
        static let userTrades:String = "/users/trades/info"
        static let userProfileTrades:String = "/users/trades/profile/info"
    }
    
    //Score´s petitions
    enum Score {
        static let getScores:String = "/scores/list"
    }

    //Trading´s petitions
    enum Trading{
        static let getTradingHistory:String = "/trades/history"
    }

    //Deposit´s petitions
    enum Wallet{
        static let getInfo:String = "/wallets/info"
        static let deposit:String = "/wallets/deposit"
        static let cash:String = "/wallets/cash"
    }
        
    //Currency´s petitions
    enum Coin{
        static let getList:String = "/coins/list"
        static let getPrice:String = "/coins/get/price"
        static let convertQuantity:String = "/coins/convert/quantity"
        static let history:String = "/coins/history"
        static let quantities:String = "/coins/quantities"
    }
}

    
    


