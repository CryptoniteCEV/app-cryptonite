

import UIKit

class CompleteViewController: UIViewController {

    
    @IBOutlet weak var date_picker: UITextField!
    let date = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
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
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        
        date_picker.text = formatter.string(from: date.date)
        self.view.endEditing(true)
    }
    
}
