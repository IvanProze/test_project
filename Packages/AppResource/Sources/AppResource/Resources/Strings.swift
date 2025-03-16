import Foundation

public enum Strings {
    
    public enum TabBar {
        public static let setting = label("Setting")
        public static let home = label("Translator")
    }
    
    public enum Home {
        public static let title = label("Translator")
        public static let human = label("Human")
        public static let pet = label("Pet")
        public static let startSpeak = label("Start Speak")
        public static let recording = label("Recording...")
        public static let processOfTranslation = label("Process of translation...")
        public static let result = label("Result")
        public static let repeat_ = label("Repeat")
    }
    
    public enum Setting {
        public static let rateUs = label("Rate Us")
        public static let shareApp = label("Share App")
        public static let contactUs = label("Contact Us")
        public static let restorePurchases = label("Restore Purchases")
        public static let privacyPolicy = label("Privacy Policy")
        public static let termsOfUse = label("Terms of Use")
        public static let title = label("Setting")

    }
    
    private static func label(_ key: String, _ args: CVarArg...) -> String {
        let format = Bundle.module.localizedString(forKey: key, value: key, table: "Localizable")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

