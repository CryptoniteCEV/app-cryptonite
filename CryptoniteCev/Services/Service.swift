
import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    private init() {}
    
    /**
     Comprueba si hay comexión a internet
     */
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }

    //Recibe params (user y pass) , devuelve datos de la petición
    func login(parameters:[String:String])-> DataRequest{
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.login, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)

    }
    
    /**
        Recibe un usuario que registrará en la petición
     */
    func register(user:User)-> DataRequest {
        
        return AF.request(Endpoints.domain + Endpoints.path+Endpoints.User.register, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
        
    }
    
    //Recibe params (email) , devuelve datos de la petición
   func restorePassword(parameters:[String:String])-> DataRequest {

       return AF.request(Endpoints.domain + Endpoints.path+Endpoints.User.restorePassword, method: .put, parameters:parameters , encoder: JSONParameterEncoder.default)
   }
    
    /**
     Petición de recoger monedas
     */
    func getCoins()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.getList, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Petición de recoge wallets que posee el usuario loggeado
    */
    func getCoinsWithQuantities()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.quantities, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Petición de recoge wallets que posee el usuario loggeado
    */
    func getWallets()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.getInfo, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Petición de recoge el cash total que posee el usuario loggeado
    */
    func getCash()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.cash, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Historial de transacciones general
     */
    func getTradingHistory()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Trading.getTradingHistory, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Trades de un usuario diferente del logeado
     */
    func getProfileTradesInfo(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.userProfileTrades, method: .get,parameters: parameters ,encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Tradeos del usuario loggeado
     */
    func getTradesInfo()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.userTrades, method: .get ,encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Crea un nuevo tradeo
     */
    func newTrade(parameters:[String:String])-> DataRequest{
        
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.trade, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default,headers: headers)
        
    }
    /**
     Recibe usuarios
     */
    func getUsers()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.all, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    /**
     Porcentajes de monedas que posee un user
     */
    func getPercentages(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.percentages, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Información de la moneda pasada
     */
    func getCoinInfo(parameters:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.coinInfo, method: .get, parameters:parameters, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Genera un nuevo follow en el usuario registrado
     */
    func followUser(params:[String:String])->DataRequest {
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.followUser, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers)
    }
    
    /**
     Recibe toda la gente seguida por el user loggeado
     */
    func getFollowings()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.getFollowings, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Petición que se encargará de hacer unfollow
     */
    func stopFollowing(params:[String:String])->DataRequest {
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.stopFollowing, method: .delete, parameters: params, encoder: JSONParameterEncoder.default, headers: headers)
    }
    
    /**
     Historial de una moneda de los ultimos 30 dias, usado para representar en gráficas
     */
    func getCoinHistory(params:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Coin.history, method: .get,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    //devuelve las missiones del usuario, genera una nueva mission y borra la terminada
    func assignNewMission(params:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.assignNewMission, method: .post,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    //Recibe la que se acaba de hacer para actualizarla a finish en la bbdd
    func updateMissionToFinish(params:[String:String])->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.missionFinished, method: .post,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     info que se mostrará en la pantalla de gamificación del usuario
     */
    func gamification()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.gamification, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     envia la nueva experiencia tras terminar una mision
     */
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
    
    //Deposita dinero en forma de doges
    func desposit(params:[String:Double])->DataRequest{
            let headers:HTTPHeaders = [
                ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
            ]
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.deposit, method: .put,parameters: params, encoding: URLEncoding.default, headers: headers)
    }
    
    //recoge porcentajes del user logged
    func getOwnPercentages()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.Wallet.percentagesOwn, method: .get, encoding: URLEncoding.default, headers: headers)
    }
    
    /**
     Recibe las misiones del usuario logeado
     */
    func getMissions()->DataRequest{
        let headers:HTTPHeaders = [
            ApiBodyNames.shared.apiToken : "Bearer " + UserDefaults.standard.string(forKey: Identifiers.shared.auth)!
        ]
    
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.getMissions, method: .get, encoding: URLEncoding.default, headers: headers)
    }
}

    

