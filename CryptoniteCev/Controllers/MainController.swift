import Foundation

class MainController {
    
    //Genera y devuelve array (String) de imagenes de perfil de los usuarios pasados
    func generateImageList(users:[User])->[String]{
        
        var imagesList:[String] = []
        
        for user in users {
            imagesList.append(user.profilePic)
        }
        
        return imagesList
    }
    
}

