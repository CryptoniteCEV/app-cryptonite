

import UIKit

class LogInController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var passwordTF: UnderlinedTextField!
    
    @IBOutlet weak var introLabel: UILabel!
    //let apiBodyResponses = ApiBodyResponses.shared
    let identifiers = Identifiers.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        logInButton.layer.cornerRadius = 5
        introLabel.text = Welcomings.shared.phrases[Int.random(in: 0..<Welcomings.shared.phrases.count)]
    }


    @IBAction func LogInButton(_ sender: Any) {
        
        if checkUsername(textFieldUsername:usernameTF/*, errorLabel: ErrorUserLabel*/) && checkPassword(textFieldPass: passwordTF/*, errorLabel: ErrorPassLabel*/){
            let apiBodyNames = ApiBodyNames.shared
            let parameters =
                [apiBodyNames.username:usernameTF.text!,
                 apiBodyNames.password:passwordTF.text!]
            
            if Service.isConnectedToInternet {
                let request = Service.shared.login(parameters: parameters)
                
                request.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        if(response.response?.statusCode == StatusCodes.shared.OK){
                            UserDefaults.standard.set(body["data"], forKey: self.identifiers.auth)
                            self.navigationController?.setNavigationBarHidden(true, animated: true)
                            self.performSegue(withIdentifier: self.identifiers.toMain, sender: sender)
                        }else{
                            print(body["message"]!)
                        }
                    }else{
                        self.navigationController?.setNavigationBarHidden(true, animated: true)
                        self.performSegue(withIdentifier: self.identifiers.toMain, sender: sender)
                    }
                }
            }else{
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.performSegue(withIdentifier: self.identifiers.toMain, sender: sender)
            }
        }
    }
    
    
    @IBAction func goToSignUp(_ sender: Any) {
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

