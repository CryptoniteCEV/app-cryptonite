

import UIKit

class CompleteViewController: UIViewController {

    
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var date_picker: UITextField!
    let date = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        finishButton.layer.cornerRadius = 5
      createDatePicker()
    }
    
    @IBAction func goToLogInScreen(_ sender: Any) {
        
        navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    //crea el date picker que sale al pulsar en el text field
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
    //crea el boton de DONE para coger la fecha
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        
        date_picker.text = formatter.string(from: date.date)
        self.view.endEditing(true)
    }
    
}
