import Foundation

final class UserPreferencesService {
    static public let shared = UserPreferencesService()
    
    private let userDefaults = UserDefaults.standard
    
    private enum Keys: String {
        case selectedAnimal
        case translationMode
    }
    
    func saveSelectedAnimal(_ animal: Animal) {
        if let encoded = try? JSONEncoder().encode(animal) {
            userDefaults.set(encoded, forKey: Keys.selectedAnimal.rawValue)
            userDefaults.synchronize()
        }
    }
    
    func getSelectedAnimal() -> Animal? {
        guard let data = userDefaults.data(forKey: Keys.selectedAnimal.rawValue),
              let decoded = try? JSONDecoder().decode(Animal.self, from: data) else {
            return nil
        }
        return decoded
    }
    
    func saveTranslationMode(_ mode: TranslationMode) {
        if let encoded = try? JSONEncoder().encode(mode) {
            userDefaults.set(encoded, forKey: Keys.translationMode.rawValue)
            userDefaults.synchronize()
        }
    }
    
    func getTranslationMode() -> TranslationMode? {
        guard let data = userDefaults.data(forKey: Keys.translationMode.rawValue),
              let decoded = try? JSONDecoder().decode(TranslationMode.self, from: data) else {
            return nil
        }
        return decoded
    }
    
}
