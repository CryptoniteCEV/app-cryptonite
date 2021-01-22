
import Foundation
import Alamofire

/*class Requests {

    func setRequest(url:String, token:String, parameters:String)->{

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
    }
}*/
    
 //   For GET, HEAD, and DELETE requests, URLEncoding.default encodes the parameters as a query string and adds it to the URL, but for any other method (such as POST) the parameters get encoded as a query string and sent as the body of the HTTP request.
    
// In order to use a query string in a POST request, you need to change your encoding argument to URLEncoding(destination: .queryString).

    

