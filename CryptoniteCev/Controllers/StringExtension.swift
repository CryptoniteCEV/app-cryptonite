import Foundation
extension String
{
    // MARK:- Properties
    //comprueba email valido
    var isValidEmail: Bool
    {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }

    // MARK:- Methods

    //llama a la validación en concreto dependiendo del param recibido
    func validatedText(_ validationType: ValidatorType) throws
    {
        switch validationType
        {
            case .username:
                try validateUsername()
            case .email:
                try validateEmail()
            case .password:
                try validatePassword()
            case .name:
                try validateName()
            case .surname:
                try validateSurname()
        }
    }

    // MARK:- Private Methods

    //si username vacio devuelve error
    private func validateUsername() throws
    {
        if isEmpty
        {
            throw ValidationError.invalidUserName
        }
    }
    //si email erróneo devuelve error
    private func validateEmail() throws
    {
        if !isValidEmail
        {
            throw ValidationError.invalidEmail
        }

        
    }
    //si pass vacio devuelve error
    private func validatePassword() throws
    {
        if isEmpty
        {
            throw ValidationError.invalidPassword
        }
    }
    //si name vacio devuelve error
    private func validateName() throws
    {
        if isEmpty
        {
            throw ValidationError.invalidPassword
        }
    }
    //si surname vacio devuelve error
    private func validateSurname() throws
    {
        if isEmpty
        {
            throw ValidationError.invalidPassword
        }
    }
}
