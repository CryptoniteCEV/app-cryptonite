
import Foundation
import Alamofire

class UserRequests {

    //on Trial
    static func request() {
        AF.request("https://httpbin.org/get").response { response in
        debugPrint(response)
        }
    }

}
