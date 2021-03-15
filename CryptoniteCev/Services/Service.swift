
import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    private init() {}
    
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    //Recibe params (user y pass) , devuelve datos de la petición
    func login(parameters:[String:String])-> DataRequest{
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.login, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)

    }
    
    func register(user:User)-> DataRequest {
        
        return AF.request(Endpoints.domain + Endpoints.path+Endpoints.User.register, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
        
    }
    
    //Recibe params (email) , devuelve datos de la petición
   func restorePassword(parameters:[String:String])-> DataRequest {

       return AF.request(Endpoints.domain + Endpoints.path+Endpoints.User.restorePassword, method: .put, parameters:parameters , encoder: JSONParameterEncoder.default)
   }
    
    func getCoins()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.getList, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func getCoinsWithQuantities()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.quantities, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func getWallets()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.getInfo, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func getCash()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.cash, method: .get, encoding: URLEncoding.default, headers: headers)
    }

    func getTradingHistory()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Trading.getTradingHistory, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func getProfileTradesInfo(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.userProfileTrades, method: .get,parameters: parameters ,encoding: URLEncoding.default, headers: headers)
    }
    
    func getTradesInfo()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.userTrades, method: .get ,encoding: URLEncoding.default, headers: headers)
    }
    
    func newTrade(parameters:[String:String])-> DataRequest{
        
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.trade, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default,headers: headers)
        
    }
    
    func getUsers()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.all, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func getPercentages(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.percentages, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
    }
    
    func getCoinInfo(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.coinInfo, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: headers)
    }
    
    func followUser(params:[String:String])->DataRequest {
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.followUser, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers)
    }
    
    func getFollowings()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.getFollowings, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func stopFollowing(params:[String:String])->DataRequest {
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.stopFollowing, method: .delete, parameters: params, encoder: JSONParameterEncoder.default, headers: headers)
    }
    
    func getCoinHistory(params:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.history, method: .get,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    //Recibe la que se acaba de terminar
    func assignNewMission(params:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.assignNewMission, method: .post,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    //Recibe la que se acaba de hace
    func updateMissionToFinish(params:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.missionFinished, method: .post,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    func gamification()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.gamification, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    func updateExp(params:[String:Int])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.updateExperience, method: .put, parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    func updateMission(params:[String:String])->DataRequest{
            let headers:HTTPHeaders = [
                ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
            ]
        
            return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.updateMission, method: .post,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    func desposit(params:[String:Int])->DataRequest{
            let headers:HTTPHeaders = [
                ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
            ]
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.deposit, method: .put,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
}

    

