

import UIKit
import NotificationBannerSwift
import Network

let connectionBanner = Banners.shared.noConnectionBanner()
let unknownBanner = Banners.shared.unknownErrorBanner()
var isConnected:Bool = true
var attemptsMaxed:Bool = false


class LogInController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var passwordTF: UnderlinedTextField!
    
    @IBOutlet weak var introLabel: UILabel!
    //let apiBodyResponses = ApiBodyResponses.shared
    let identifiers = Identifiers.shared
    let monitor = Monitor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        logInButton.layer.cornerRadius = 5
        introLabel.text = Welcomings.shared.phrases[Int.random(in: 0..<Welcomings.shared.phrases.count)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        logInButton.isEnabled = true
        monitor.startMonitoring { [weak self] connection, reachable in
            
            if reachable == Reachable.yes && connection == Connection.wifi{
                DispatchQueue.main.async {
                    isConnected = true
                    connectionBanner.dismiss()
                }

            }else{
                DispatchQueue.main.async {
                    isConnected = false
                    
                    connectionBanner.show()
                }
            }
            
        }
        if isConnected{
            if UserDefaults.standard.string(forKey: Identifiers.shared.auth) != nil {
                self.navigationController?.setNavigationBarHidden(true, animated: true)
                self.performSegue(withIdentifier: self.identifiers.toMain, sender: (Any).self)
            }
        }
    }


    @IBAction func LogInButton(_ sender: Any) {
        
        if checkUsername(textFieldUsername: usernameTF) && checkPassword(textFieldPass: passwordTF){
            let apiBodyNames = ApiBodyNames.shared
            let parameters =
                [apiBodyNames.username:usernameTF.text!,
                 apiBodyNames.password:passwordTF.text!]
            
            login(parameters: parameters, sender: sender)
            
        }
    }
    
    func login(parameters:[String:String], sender:Any){
        
        if isConnected {
            logInButton.isEnabled = false
            let request = Service.shared.login(parameters: parameters)
            
            request.responseJSON { (response) in
                if let body = response.value as? [String: Any]{
                    if(response.response?.statusCode == StatusCodes.shared.OK){
                        attemptsMaxed = false
                        self.logInButton.isEnabled = false
                        UserDefaults.standard.set(body["data"], forKey: self.identifiers.auth)
                        self.navigationController?.setNavigationBarHidden(true, animated: true)
                        UserDefaults.standard.set(0, forKey: "numberOfTransactions")
                        UserDefaults.standard.set(0, forKey: "numberOfFollows")
                        self.performSegue(withIdentifier: self.identifiers.toMain, sender: sender)
                    }else{
                        self.logInButton.isEnabled = true
                        Banners.shared.errorBanner(title: body["message"] as! String, subtitle: "Try again!")
                    }
                }else{
                    self.logInButton.isEnabled = true
                    Banners.shared.errorBanner(title: "Something strange has occured", subtitle: "Try again!")
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    @IBAction func signUpButton(_ sender: Any) {
        logInButton.isEnabled = true
        performSegue(withIdentifier: "signup", sender: sender)
    }
}

