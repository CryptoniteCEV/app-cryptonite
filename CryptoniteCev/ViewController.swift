

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var email_text_field: UnderlinedtextField!
    @IBOutlet weak var sing_in_button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        sing_in_button.layer.cornerRadius = 5
    }


    @IBAction func validation(_ sender: Any) {
    }
}

