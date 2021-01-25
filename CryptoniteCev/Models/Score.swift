import Foundation

class Score : Decodable, Encodable{
    
    private var _level:Int
    private var _experience:Int
    
    init(experience:Int, level:Int){
        self._level = level
        self._experience = experience
    }
    
    public func getScore()->[String:Int]{
        return ["level":level, "experience":experience]
    }
    
    public var level: Int {
        get {
            return self._level;
        }
        set {
            self._level = newValue
        }
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
