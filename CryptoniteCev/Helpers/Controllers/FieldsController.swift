
import Foundation
import UIKit

/**
 Comprueba que el email sea correcto en función de ciertas validaciones del string del textfield, devielve true o false
 */
public func checkEmail(textFieldEmail:UITextField/*, errorLabel:UILabel*/) -> Bool
{
    do
    {
        try textFieldEmail.validatedText(.email)
        //errorLabel.isHidden = true
    }
    catch let error
    {
        let validationError = error as! ValidationError
        //errorLabel.isHidden = false
        //errorLabel.text = validationError.localizedDescription
        return false
    }

    return true
}

/**
Comprueba que el password textfield no este vacio, devielve true o false
 En caso de false hace animación en textfield
*/
public func checkPassword(textFieldPass:UITextField/*, errorLabel:UILabel*/) -> Bool
{
    do
    {
        try textFieldPass.validatedText(.password)
        //errorLabel.isHidden = true
    }
    catch let error
    {
        let validationError = error as! ValidationError
        //errorLabel.isHidden = false
        //errorLabel.textColor = #colorLiteral(red: 0.9490196078, green: 0.2862745098, blue: 0.4509803922, alpha: 1)
        //errorLabel.text = validationError.localizedDescription
        return false
    }

    return true
}

/**
Comprueba que el username textfield no este vacio, devielve true o false
 En caso de false hace animación en textfield
*/
public func checkUsername(textFieldUsername:UITextField/*, errorLabel:UILabel*/) -> Bool
{
    do
    {
        try textFieldUsername.validatedText(.username)
        //errorLabel.isHidden = true
    }
    catch let error
    {
        let validationError = error as! ValidationError
        //errorLabel.isHidden = false
        //errorLabel.text = validationError.localizedDescription
        return false
    }

    return true
}

/**
Comprueba que el name  textfield no este vacio, devielve true o false
 En caso de false hace animación en textfield
*/
public func checkName(textFieldName:UITextField/*, errorLabel:UILabel*/) -> Bool
{
    do
    {
        try textFieldName.validatedText(.name)
        //errorLabel.isHidden = true
    }
    catch let error
    {
        let validationError = error as! ValidationError
        //errorLabel.isHidden = false
        //errorLabel.text = validationError.localizedDescription
        return false
    }

    return true
}

