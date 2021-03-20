
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
    
    /**
     Al iniciarse el view por primera vez el botón de continuar se redondea y
     se llama a la función que permitirá cerrar el teclado
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        continue_button.layer.cornerRadius = 5
        
    }
    /**
     Al aparecer el view el botón se habilita y el nav controller aparece
     */
    override func viewDidAppear(_ animated: Bool) {
        continue_button.isEnabled = true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    /**
     Al pulsar el botón de continuar, se comprueban los datos introducidos, si son correcto se llama a la petición de registrar, en caso de ser erróneos se mostrará el mensaje en forma de banner y se habilitará el botón de continuar
     */
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
    /**
     Función engargada de mostrar el banner una vez te registres correctamente
     */
    func showBanner(completion: @escaping (_ success: Bool) -> Void, message: String) {
        Banners.shared.successBanner(title: message, subtitle: "Log in now!")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(true)
        }
    }
    
    /**
     Función que se encargará de las peticiones de registro con las comprobaciones necesarias además de llevarte a login una vez esto ocurra correctamente, en caso de ocurrir cualquier error se mostrará un mensaje en forma de banner
     */
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
    
    
    /**
     Ibaction que te llevará a la pantalla de login una vez se pulse el botón de "log in"
     */
    @IBAction func goToLogIn(_ sender: Any) {
         navigationController?.popToRootViewController(animated: true)
    }
    
    /**
     Función que te devolverá a la pantalla de login
     */
    func goToLogInScreen() {
        navigationController?.popToRootViewController(animated: true)
        
    }
    
}
