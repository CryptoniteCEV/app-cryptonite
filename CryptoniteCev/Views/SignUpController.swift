
import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var continue_button: UIButton!
    
    @IBOutlet weak var emailTF: UnderlinedTextField!
    @IBOutlet weak var emailErrorL: UILabel!
    
    @IBOutlet weak var passwordTF: UnderlinedTextField!
    @IBOutlet weak var passwordErrorL: UILabel!
    
    
    let identifiers = Identifiers.shared
    @IBOutlet weak var isAdultSW: UISwitch!
    @IBOutlet weak var isAdultErrorL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        continue_button.layer.cornerRadius = 5
        
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        if checkEmail(textFieldEmail: emailTF, errorLabel: emailErrorL) && checkPassword(textFieldPass: passwordTF, errorLabel: passwordErrorL){
            if isAdultSW.isOn{
                isAdultErrorL.isHidden = true
                self.performSegue(withIdentifier: self.identifiers.toCompletion, sender: sender)
            }else {
                isAdultErrorL.isHidden = false
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
