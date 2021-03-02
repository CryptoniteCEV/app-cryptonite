import Foundation

class Score : Decodable, Encodable{
    
    private var _experience:Int
    
    init(experience:Int){
        self._experience = experience
    }
    
    public var experience: Int {
        get {
            return self._experience;
        }
        set {
            self._experience = newValue
        }
    }
}
