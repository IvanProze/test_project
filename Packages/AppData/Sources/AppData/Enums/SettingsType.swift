import UIKit
import AppResource

public enum SettingsEnum {
    static let sections: [[SettingsEnum]] = [[.rateUs, .share, .contact, .restore,.privacy, .terms]]
    
    case premium
    
    case share
    case rateUs
    case contact
    case restore
    case terms
    case privacy
    
    var title: String {
        switch self {
        case .premium:
            return ""
        case .share:
            return Strings.Setting.shareApp
        case .rateUs:
            return Strings.Setting.rateUs
        case .contact:
            return Strings.Setting.contactUs
        case .restore:
            return Strings.Setting.restorePurchases
        case .terms:
            return Strings.Setting.termsOfUse
        case .privacy:
            return Strings.Setting.privacyPolicy
        }
    }
}
