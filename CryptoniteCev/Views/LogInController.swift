

import UIKit

class LogInController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 5
    }


    @IBAction func validation(_ sender: Any) {
        
        
    }
    @IBAction func goToSignUp(_ sender: Any) {
    }
    
    @IBAction func requestPrueba(_ sender: UIButton) {
        
        //Service.shared.getUsers()
        //Service.shared.postUsers()
    }
}

