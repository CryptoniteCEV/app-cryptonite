

import UIKit
import Foundation

class CompleteViewController: UIViewController {

    
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var nameTF: UnderlinedTextField!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var surnameTF: UnderlinedTextField!
    @IBOutlet weak var date_picker: UITextField!
    let date = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishButton.layer.cornerRadius = 5
        createDatePicker()
    }
    
    func createDatePicker(){
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        
        date_picker.inputAccessoryView = toolbar
        
        date_picker.inputView = date
        date.datePickerMode = .date
    }
    
    @objc func donePressed(){
        
        date_picker.text = formatDate()
        
        let user = User(username: usernameTF.text!, email: "arroba", name: nameTF.text!, surname: surnameTF.text!, profilePic: "asd", password: "1234", dateOfBirth: formatDate())
        
        self.view.endEditing(true)
    }
    
    func formatDate() -> String{
        
        let dateString = date.date.description
        let dateSeparated = dateString.split(separator: " ")
        return dateSeparated.first!.description
    }

    
}
