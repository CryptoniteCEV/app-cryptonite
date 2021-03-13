import Foundation

//Tipos de validación
enum ValidatorType
{
    case email
    case name
    case password
    case username

}
//tipos de error
enum ValidationError: Error, LocalizedError
{
    case invalidUserName
    case invalidEmail
    case invalidPassword
    case invalidName

//Errores concretos
    var localizedDescription: String
    {
        let userMessages = UserMessages.shared
        
        switch self
        {
            case .invalidEmail:
                return userMessages.invalidEmail
            case .invalidUserName:
                return userMessages.invalidUsername
            case .invalidPassword:
                return userMessages.invalidPass
            case .invalidName:
                return userMessages.invalidName
            
        }
    }
}
