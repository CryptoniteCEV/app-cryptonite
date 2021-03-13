
import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var continue_button: UIButton!
    
    @IBOutlet weak var emailTF: UnderlinedTextField!
    @IBOutlet weak var passwordTF: UnderlinedTextField!
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var nameTF: UnderlinedTextField!
    
    let identifiers = Identifiers.shared
    @IBOutlet weak var isAdultSW: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        continue_button.layer.cornerRadius = 5
        
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        if checkEmail(textFieldEmail: emailTF) && checkPassword(textFieldPass: passwordTF){
            if isAdultSW.isOn{
                //isAdultErrorL.isHidden = true
                //self.performSegue(withIdentifier: self.identifiers.toCompletion, sender: sender)
                
                let user = User(username: usernameTF.text!, email: emailTF.text!, name: nameTF.text!, password: passwordTF.text!, profilePic: Int.random(in: 0..<Images.shared.users.count))
                
                if Service.isConnectedToInternet {
                    let request = Service.shared.register(user: user)
                    
                    request.responseJSON { (response) in
                        if let body = response.value as? [String: Any]{
                            if(response.response?.statusCode == StatusCodes.shared.created){
                                self.goToLogInScreen()
                            }else{
                                print(body["message"]!)
                            }
                        }
                    }
                }
            }else {
                
            }
        }
    }
    
    /**
    Comprueba identificador a la hora de realizar segue y pasa email y pass a la siguiente pantalla
    */
   /*override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       if(segue.identifier == identifiers.toCompletion){
           let controller = segue.destination as! CompleteViewController
           controller.email = emailTF.text!
           controller.password = passwordTF.text!
       }
   }*/
    
    
    @IBAction func goToLogIn(_ sender: Any) {
         navigationController?.popToRootViewController(animated: true)
    }
    
    func goToLogInScreen() {
        
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}
