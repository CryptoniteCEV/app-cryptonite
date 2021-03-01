

import UIKit

class LogInController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var passwordTF: UnderlinedTextField!
    
    //let apiBodyResponses = ApiBodyResponses.shared
    let identifiers = Identifiers.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 5
    }


    @IBAction func LogInButton(_ sender: Any) {
        
         let request = Service.shared.getCoins()
        
        request.responseJSON { (response) in
            let body = response.value as? [String: Any]
            //print(body!["data"]!)
            let data = body!["data"]!
            
            for coin in data as! [[String:Any]]{
                print(coin)
            }
            
        }
        /*if checkUsername(textFieldUsername:usernameTF/*, errorLabel: ErrorUserLabel*/) && checkPassword(textFieldPass: passwordTF/*, errorLabel: ErrorPassLabel*/){
            let apiBodyNames = ApiBodyNames.shared
            let parameters =
                [apiBodyNames.username:usernameTF.text!,
                 apiBodyNames.password:passwordTF.text!]
            
            let request = Service.shared.login(parameters: parameters)
            
            request.responseJSON { (response) in
                let body = response.value as? [String: Any]
                if(response.response?.statusCode == StatusCodes.shared.OK){
                    UserDefaults.standard.set(body!["data"]!, forKey: self.identifiers.auth)
                    self.navigationController?.setNavigationBarHidden(true, animated: true)
                    self.performSegue(withIdentifier: self.identifiers.toMain, sender: sender)
                }else{
                    print(body!["message"]!)
                }
            }
        }*/
    }
    
    
    @IBAction func goToSignUp(_ sender: Any) {
    }
}

