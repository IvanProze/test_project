import Foundation

public enum Animations: String {
    case wave
    
    public var path: URL {
        return Bundle.module.url(forResource: self.rawValue, withExtension: "gif") ?? URL(string: "1")!
    }
}
