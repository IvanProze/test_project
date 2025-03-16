import UIKit
import SwifterSwift
import AppResource

public enum Animal: Codable {
    case dog
    case cat
    
    var imag: UIImage {
        switch self {
        case .cat: return Images.cat
        case .dog: return Images.dog
        }
    }
}

public enum TranslationMode: String, Codable {
    case toPet
    case toHuman
}

final class TranslateManager {
    static let shared = TranslateManager()
    
    private let generatedValues: [String?] = [
        nil,
        nil,
        nil,
        nil,
        nil,
        "Feed me, please!",
        "Can we play now?",
        "I missed you so much!",
        "I love you unconditionally.",
        "Nap time is the best time.",
        "Did you bring me a treat?",
        "Can I sit on your lap?",
        "Please don’t leave me alone.",
        "Why do you keep calling me cute?",
        "Let’s go for a walk!",
        "I’m the best friend you’ll ever have.",
        "Are you feeling sad? I’ll cheer you up!",
        "I don’t like baths, but I love you.",
        "Pet me, pet me, pet me!",
        "I trust you with my whole heart."
    ]
    
    var selectedAnimal: Animal {
        get {
            return UserPreferencesService.shared.getSelectedAnimal() ?? .cat
        }
        set {
            UserPreferencesService.shared.saveSelectedAnimal(newValue)
            NotificationCenter.default.post(name: .setAnimal, object: nil, userInfo: nil)
        }
    }
    
    var translationMode: TranslationMode {
        get {
            return UserPreferencesService.shared.getTranslationMode() ?? .toPet
        }
        set {
            UserPreferencesService.shared.saveTranslationMode(newValue)
        }
    }
    
    func translateFromPetToHuman(file: URL, completion: @escaping (String?) -> Void) {
        let randomDelay = TimeInterval(Int.random(in: 2...3))
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) { [weak self] in
            guard let self = self else { return }
            completion(self.generatedValues.randomElement() ?? nil)
        }
    }
    
    func translateFromHumanToPet(completion: @escaping (String?) -> Void) {
        completion(nil)
    }
}
