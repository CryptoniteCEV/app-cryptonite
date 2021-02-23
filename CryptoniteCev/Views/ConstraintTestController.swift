

import UIKit

class ConstraintTestController: UIViewController {

    @IBOutlet weak var redViewç: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        redViewç.translatesAutoresizingMaskIntoConstraints = false

               let leadingConstraint = NSLayoutConstraint(item: redViewç, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
               let trailingConstraint = NSLayoutConstraint(item: redViewç, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
               let topConstraint = NSLayoutConstraint(item: redViewç, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 50)
               let bottomConstraint = NSLayoutConstraint(item: redViewç, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -400)
               view.addConstraints([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])


               
            }
    

    

}
