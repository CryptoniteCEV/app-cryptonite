
import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var continue_button: UIButton!
    
    @IBOutlet weak var emailTF: UnderlinedTextField!
    
    @IBOutlet weak var passwordTF: UnderlinedTextField!
    
    let identifiers = Identifiers.shared
    @IBOutlet weak var isAdultSW: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        continue_button.layer.cornerRadius = 5
        
    }
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        if checkEmail(textFieldEmail: emailTF/*, errorLabel: ErrorUserLabel*/) && checkPassword(textFieldPass: passwordTF/*, errorLabel: ErrorPassLabel*/){
            if isAdultSW.isOn{
                self.performSegue(withIdentifier: self.identifiers.toCompletion, sender: sender)
            }
        }
    }
    
    /**
    Comprueba identificador a la hora de realizar segue y pasa email y pass a la siguiente pantalla
    */
   override func prepare(for segue: UIStoryboardSegue, sender: Any?){
       if(segue.identifier == identifiers.toCompletion){
           let controller = segue.destination as! CompleteViewController
           controller.email = emailTF.text!
           controller.password = passwordTF.text!
       }
   }
    
    
    @IBAction func goToLogIn(_ sender: Any) {
         navigationController?.popToRootViewController(animated: true)
    }
    
}
