
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
        continue_button.isEnabled = true
        self.hideKeyboardWhenTappedAround()
        continue_button.layer.cornerRadius = 5
        
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @IBAction func ContinueButton(_ sender: Any) {
        
        if checkEmail(textFieldEmail: emailTF) && checkPassword(textFieldPass: passwordTF){
            if isAdultSW.isOn{
                let user = User(username: usernameTF.text!, email: emailTF.text!, name: nameTF.text!, password: passwordTF.text!, profilePic: Int.random(in: 0..<Images.shared.users.count))
                
                register(user: user)
            }else {
                Banners.shared.errorBanner(title: "You have to agree our Terms and conditions ", subtitle: "Try again")
                continue_button.isEnabled = true
            }
        }
    }
    func showBanner(completion: @escaping (_ success: Bool) -> Void, message: String) {
        Banners.shared.successBanner(title: message, subtitle: "Log in now!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(true)
        }
    }
    
    func register(user:User){
        
        if isConnected {
            let request = Service.shared.register(user: user)
            continue_button.isEnabled = false
            request.responseJSON { (response) in
                if let body = response.value as? [String:Any]{
                    if(response.response?.statusCode == StatusCodes.shared.OK){
                        self.showBanner(completion: { (success) in
                            if success {
                                attemptsMaxed = false
                                self.continue_button.isEnabled = true
                                self.goToLogInScreen()
                            }
                        }, message: body["message"]! as! String)
                    }else{
                        let errorMessages = body["message"] as! [String:[String]]
                        let firstKey = Array(errorMessages.keys).first
                        Banners.shared.errorBanner(title: (errorMessages[firstKey!]?.first)!, subtitle: "Try again")
                        self.continue_button.isEnabled = true
                    }
                }
            }
        }
    }
    
    
    @IBAction func goToLogIn(_ sender: Any) {
         navigationController?.popToRootViewController(animated: true)
    }
    
    func goToLogInScreen() {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}
