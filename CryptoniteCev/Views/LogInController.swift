

import UIKit

class LogInController: UIViewController {

    @IBOutlet weak var logInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        logInButton.layer.cornerRadius = 5
    }


    @IBAction func validation(_ sender: Any) {
        //navigationController?.setNavigationBarHidden(true, animated: true)
        //Service.getUsers()
        //Service.shared.postUsers()
    }
    @IBAction func goToSignUp(_ sender: Any) {
    }
}

