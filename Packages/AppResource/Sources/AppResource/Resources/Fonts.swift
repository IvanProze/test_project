import UIKit

public enum Fonts {
    public enum KonkhmerSleokchher: String {
        case regular = "Regular"
    }
    
    public static func konkhmerSleokchherProper(type: KonkhmerSleokchher, _ iphoneSize: CGFloat, _ ipadSize: CGFloat? = nil) -> UIFont {
        let correctIpadSize = ipadSize ?? (iphoneSize + 3.0)
        let size = UIDevice.current.userInterfaceIdiom == .pad ? correctIpadSize : iphoneSize
        return Font(name: "KonkhmerSleokchher-\(type.rawValue)", size)
    }
 
    
    public static func konkhmerSleokchherRegular(_ size: CGFloat) -> UIFont {
        return Font(name: "KonkhmerSleokchher-Regular", size)
    }
    
    private static func Font(name: String, _ size: CGFloat) -> UIFont {
        return FontConvertible(name: name, family: name, path: "\(name).otf").font(size: size)
    }
}


// MARK: - Implementation Details

public struct FontConvertible {
    public let name: String
    public let family: String
    public let path: String
    
        #if os(macOS)
    public typealias Font = NSFont
        #elseif os(iOS) || os(tvOS) || os(watchOS)
    public typealias Font = UIFont
        #endif
    
    public func font(size: CGFloat) -> Font {
        guard let font = Font(font: self, size: size) else {
            fatalError("Unable to initialize font '\(name)' (\(family))")
        }
        return font
    }
    
    public func register() {
        // swiftlint:disable:next conditional_returns_on_newline
        guard let url = url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }
    
    fileprivate func registerIfNeeded() {
        #if os(iOS) || os(tvOS) || os(watchOS)
        if !UIFont.fontNames(forFamilyName: family).contains(name) {
            register()
        }
        #elseif os(macOS)
        if let url = url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
            register()
        }
        #endif
    }
    
    fileprivate var url: URL? {
        // swiftlint:disable:next implicit_return
        return BundleToken.bundle.url(forResource: path, withExtension: nil)
    }
}

public extension FontConvertible.Font {
    convenience init?(font: FontConvertible, size: CGFloat) {
        font.registerIfNeeded()
        self.init(name: font.name, size: size)
    }
}

// swiftlint:disable convenience_type
private final class BundleToken {
    static let bundle: Bundle = {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        return Bundle(for: BundleToken.self)
        #endif
    }()
}
// swiftlint:enable convenience_type
