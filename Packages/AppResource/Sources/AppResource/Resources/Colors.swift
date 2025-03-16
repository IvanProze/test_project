import UIKit
public enum Colors {
    public static let main = Color(named: "Main")
    public static let sky = Color(named: "Sky")
    public static let text = Color(named: "Text")
    public static let background = Color(named: "Background")
    public static let shadow = Color(named: "Shadow")
    public static let subMain = Color(named: "SubMain")
    public static let lightGreen = Color(named: "LightGreen")
    public static let subShadow = Color(named: "SubShadow")
    
    public static func gradientBackground(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [Colors.main.cgColor, Colors.subMain.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private static func Color(named: String) -> UIColor {
        return UIColor(named: named, in: .module, compatibleWith: nil)!
    }
}
