import UIKit

final public class NavigationService: NSObject {
    var tabBarViewController: TabBarViewController? = nil
    
    static public let shared = NavigationService()
    
    private var topViewController: UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = scene.windows.first?.rootViewController else {
            return nil
        }
        return getTopViewController(from: rootVC)
    }
    
    private func getTopViewController(from root: UIViewController?) -> UIViewController? {
        if let presented = root?.presentedViewController {
            return getTopViewController(from: presented)
        } else if let nav = root as? UINavigationController {
            return getTopViewController(from: nav.visibleViewController)
        } else if let tab = root as? UITabBarController {
            return getTopViewController(from: tab.selectedViewController)
        } else {
            return root
        }
    }
    
    private func setRootViewController(window: UIWindow, viewController: UIViewController) {
        window.rootViewController = viewController
        window.overrideUserInterfaceStyle = .dark
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil)
    }
    
    public func runApp(for window: UIWindow) {
        let storyboard = UIStoryboard(name: "TabBarViewController", bundle: .module)
        guard let tabBarVC = storyboard.instantiateViewController(identifier: "TabBarViewController") as? TabBarViewController else {
            return
        }
        self.tabBarViewController = tabBarVC
        setRootViewController(window: window, viewController: tabBarVC)
        AudioRecorderManager.shared.prepareSession()
        
    }
}

//MARK: Public
extension NavigationService {
    func presentMicrophoneSettingsAlert() {
        guard let topVC = topViewController else { return }
        let alert = UIAlertController(title: "Enable Microphone Access", message: "Please allow access to your mircophone to use the app’s features", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
            }
        }))
        topVC.present(alert, animated: true, completion: nil)
    }
    
    func presentFeatureComingSoonAlert() {
        guard let topVC = topViewController else { return }
        let alert = UIAlertController(
            title: "Feature Coming Soon",
            message: "This feature will be added soon.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        topVC.present(alert, animated: true, completion: nil)
    }
    
    public func presentResultScreen(text: String?, typeAnimal: Animal, file: URL) {
        guard let topVC = topViewController else { return }
        let resultVC = ResultViewController(text: text, typeAnimal: typeAnimal, file: file)
        resultVC.modalPresentationStyle = .fullScreen
        topVC.present(resultVC, animated: true)
    }
}
