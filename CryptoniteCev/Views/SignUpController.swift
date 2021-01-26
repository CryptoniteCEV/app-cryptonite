
import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var backButton: UINavigationItem!
    @IBOutlet weak var continue_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        continue_button.layer.cornerRadius = 5
     
        
    }
    @IBAction func goToLogIn(_ sender: Any) {
         navigationController?.popToRootViewController(animated: true)
    }
    
}
