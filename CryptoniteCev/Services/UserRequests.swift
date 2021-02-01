import Foundation
import Alamofire

class Requests {
    
    static let shared = Requests()
    
    private init() {
        
    }
    
    func getUsers() -> DataRequest {
        
        
        return AF.request(Endpoints.shared.baseUrl+Endpoints.User.all, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor:nil)
        
    }
    
    func registerUser(user:User) {

        AF.request(Endpoints.shared.baseUrl+Endpoints.User.register, method: .post, parameters: user, encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        }
    }
    
    func restorePassword(parameters:[String:String]) {

        AF.request(Endpoints.shared.baseUrl+Endpoints.User.restorePassword, method: .post, parameters:parameters , encoder: JSONParameterEncoder.default).response { response in
            debugPrint(response)
        
        }
    }
    
    func login(parameters:[String:String])  -> DataRequest{

        return AF.request(Endpoints.shared.baseUrl+Endpoints.User.login, method: .post, parameters:parameters , encoder: JSONParameterEncoder.default)
    }
}
