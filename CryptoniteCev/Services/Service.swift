
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
    
    func getCoinInfo(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.coinInfo, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: headers)
    }
    
}
    
    /*func setRequest(url:String, token:String, parameters:String)->{

        let headers: HTTPHeaders = ["api_token": token]
        AF.
        return AF.request(url,
               method: .post,
               parameters: parameters,
               encoder: JSONParameterEncoder.default,
               headers: headers)
        

    }
    
    func get(){
        // Receive and decode the server's JSON response.
       request.responseDecodable(of: Trade.self) { response in
           switch response.result {
               case let .success(result):
                 // the decoded result of type 'Article' that you received from the server.
               print("Result is: \(result)")
               case let .failure(error):
                 // Handle the error.
               print("Error description is: \(error.localizedDescription)")
           }
       }
    }*/

    
 //   For GET, HEAD, and DELETE requests, URLEncoding.default encodes the parameters as a query string and adds it to the URL, but for any other method (such as POST) the parameters get encoded as a query string and sent as the body of the HTTP request.
    
// In order to use a query string in a POST request, you need to change your encoding argument to URLEncoding(destination: .queryString).

    

