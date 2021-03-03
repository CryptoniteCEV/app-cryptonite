

import UIKit

class CompleteViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var date_picker: UITextField!
    let date = UIDatePicker()
    
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var nameTF: UnderlinedTextField!
    var email:String?
    var password:String?
    @IBOutlet weak var surnameTF: UnderlinedTextField!
    
    let identifiers = Identifiers.shared
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        finishButton.layer.cornerRadius = 5
        createDatePicker()
    }
    
    func goToLogInScreen() {
        
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
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        
        date_picker.text = formatter.string(from: date.date)
        self.view.endEditing(true)
    }
    
    
    @IBAction func FinishedButton(_ sender: Any) {
        
        let user = User(username: usernameTF.text!, email: email!, name: nameTF.text!, surname: surnameTF.text!, password: password!, date_of_birth: /*date_picker.text!*/"2020-12-02")
        
        if Service.isConnectedToInternet {
            let request = Service.shared.register(user: user)
            
            request.responseJSON { (response) in
                if let body = response.value as? [String: Any]{
                    if(response.response?.statusCode == StatusCodes.shared.created){
                        self.goToLogInScreen()
                    }else{
                        print(body["message"]!)
                    }
                }
            }
        }
    }
}
    

