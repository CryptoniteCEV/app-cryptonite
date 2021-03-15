import Foundation

class Endpoints {
    
    private init() {}
    
    let shared = Endpoints()
    
    static let domain = "http://52.90.76.43"
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
        static let all:String = "/users/list"
        static let userTrades:String = "/users/trades/info"
        static let userProfileTrades:String = "/users/trades/profile/info"
        static let someonesInfo:String = "/users/info"
        static let stopFollowing:String = "/users/stop/following"
        static let assignNewMission:String = "/users/assign/mission"
        static let missionFinished:String = "/users/update/mission"
        static let gamification:String = "/users/gamification"
        static let updateMission:String = "/users/update/mission"
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
        static let deposit:String = "/wallets/deposit/doge"
        static let cash:String = "/wallets/cash"
        static let percentages:String = "/wallets/percentages"
    }
        
    //Currency´s petitions
    enum Coin{
        static let getList:String = "/coins/list"
        static let getPrice:String = "/coins/get/price"
        static let convertQuantity:String = "/coins/convert/quantity"
        static let history:String = "/coins/history"
        static let quantities:String = "/coins/quantities"
        static let coinInfo:String = "/coins/info"
    }
    
}

    
    


