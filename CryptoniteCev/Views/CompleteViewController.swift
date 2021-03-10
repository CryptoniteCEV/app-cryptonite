

import UIKit

class CompleteViewController: UIViewController {

    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var date_picker: UITextField!
    let date = UIDatePicker()
    @IBOutlet weak var datePickerErrorL: UILabel!
    
    @IBOutlet weak var usernameTF: UnderlinedTextField!
    @IBOutlet weak var usernameErrorL: UILabel!
    @IBOutlet weak var nameTF: UnderlinedTextField!
    @IBOutlet weak var nameErrorL: UILabel!
    var email:String?
    var password:String?
    @IBOutlet weak var surnameTF: UnderlinedTextField!
    @IBOutlet weak var surnameErrorL: UILabel!
    
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
        
        if checkUsername(textFieldUsername: usernameTF, errorLabel: usernameErrorL) && checkName(textFieldName: nameTF, errorLabel: nameErrorL) && checkSurname(textFieldSurname: surnameTF, errorLabel: surnameErrorL){
            
            let user = User(username: usernameTF.text!, email: email!, name: nameTF.text!, surname: surnameTF.text!, password: password!, date_of_birth: /*date_picker.text!*/"2020-12-02")
            
            if Service.isConnectedToInternet {
                let request = Service.shared.register(user: user)
                
                request.responseJSON { (response) in
                    if let body = response.value as? [String: Any]{
                        if(response.response?.statusCode == StatusCodes.shared.created){
                            self.goToLogInScreen()
                        }else{
                            //Banners.shared.errorBanner(title: body["message"] as! String, subtitle: "Try again!")
                            print(body["message"]!)
                        }
                    }
                }
            }else{
                Banners.shared.noConnectionBanner()
            }
        }
    }
}
    

