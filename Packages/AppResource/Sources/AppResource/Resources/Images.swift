import UIKit

public enum Images {
    //Tab bar
    public static let setting = Image(named: "setting")
    public static let messages = Image(named: "messages")
    
    //Home
    public static let cat = Image(named: "cat")
    public static let dog = Image(named: "dog")
    public static let microphone = Image(named: "microphone")
    public static let reversal = Image(named: "reversal")
    public static let repeat_ = Image(named: "repeat")
    public static let close = Image(named: "close")
    
    //Settings
    public static let arrowRight = Image(named: "arrowRight")

    private static func Image(named: String) -> UIImage {
        return UIImage(named: named, in: .module, with: nil)!
    }
}
