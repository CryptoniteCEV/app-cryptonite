
import Foundation
import Alamofire

class Service {
    
    static let shared = Service()
    
    private init() {}
    
    //Recibe params (user y pass) , devuelve datos de la petición
    func login(parameters:[String:String])-> DataRequest{
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.login, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default)

    }
    
    func register(user:User)-> DataRequest {
        
        return AF.request(Endpoints.domain + Endpoints.path+Endpoints.User.register, method: .post, parameters: user, encoder: JSONParameterEncoder.default)
        
    }
    
    func getCoins()->DataRequest{
        
        return AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.all, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor:nil)
    }
    
    func getUsers() {
        
        AF.request(Endpoints.domain + Endpoints.path + Endpoints.User.all, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil, interceptor:nil).response { (responseData) in
            guard let data = responseData.data else {return}
            
            do{
                let users = try JSONDecoder().decode([User].self, from: data)
                print("users == \(users)")
                
                for user in users{
                    print(user.email)
                }
                
            }catch{
                print("Error decoding == \(error)")
            }
        }
        
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

    

