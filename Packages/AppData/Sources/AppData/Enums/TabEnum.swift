import UIKit
import AppResource

public enum TabEnum: Int, CaseIterable {
    case home
    case settings
    
    var viewController: UIViewController {
        switch self {
        case .home: return HomeViewController(nibName: "HomeViewController", bundle: .module)
        case .settings: return SettingsViewController(nibName: "SettingsViewController", bundle: .module)
        }
    }
    
    var icon: UIImage {
        switch self {
        case .home: return Images.messages
        case .settings: return Images.setting
        }
    }
    
    var strings: String {
        switch self {
        case .home: return Strings.TabBar.home
        case .settings: return Strings.TabBar.setting
        }
    }
}

