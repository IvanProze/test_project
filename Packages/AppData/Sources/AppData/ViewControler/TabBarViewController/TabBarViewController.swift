import UIKit
import AppResource

final class TabBarViewController: UIViewController {
    //MARK: Property
    @IBOutlet private weak var barViewToSafeBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet private weak var barView: UIView!
    @IBOutlet private weak var mainScreenView: UIView!
    @IBOutlet private weak var backgroundTabBarView: UIView!
    
    @IBOutlet private var titles: [UILabel]!
    @IBOutlet private var images: [UIImageView]!
    
    private var navigationControllers: [UINavigationController] = []
    private var selectedIndex = 0
    private var currentTabIndex: Int?
    
    public var height: Double {
        return barViewToSafeBottomConstraint.constant + barView.height
    }
    
    public var currentViewController: UINavigationController? {
        guard let index = currentTabIndex else { return nil }
        return navigationControllers[index]
    }
    
    //MARK: LifeCell
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
}

//MARK: Private
private extension TabBarViewController {
    func setupScreen() {
        setButtonsTabBar()
        titles.sort { $0.tag > $1.tag }
        images.sort { $0.tag > $1.tag }
        configureSubViewController(with: 0)
        Colors.gradientBackground(view: self.view)
    }
    
    func setButtonsTabBar() {
        backgroundTabBarView.backgroundColor = Colors.background
        
        backgroundTabBarView.backgroundColor = Colors.background
        backgroundTabBarView.layer.cornerRadius = 16
        backgroundTabBarView.layer.shadowRadius = 80
        backgroundTabBarView.layer.shadowColor = Colors.subShadow.cgColor
        backgroundTabBarView.layer.shadowOpacity = 0.15
        backgroundTabBarView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backgroundTabBarView.layer.masksToBounds = false
        
        TabEnum.allCases.forEach {
            let navigationController = UINavigationController(rootViewController: $0.viewController)
            navigationController.isNavigationBarHidden = true
            
          navigationControllers.append(navigationController)
            images[$0.rawValue].image = $0.icon.withTintColor(Colors.text).withRenderingMode(.alwaysOriginal)
            images[$0.rawValue].alpha =  selectedIndex == $0.rawValue ? 1 : 0.6
            titles[$0.rawValue].text = $0.strings
            titles[$0.rawValue].textColor = selectedIndex == $0.rawValue ? Colors.text : Colors.text.withAlphaComponent(0.6)
            titles[$0.rawValue].font = Fonts.konkhmerSleokchherRegular(12)
            
        }
    }
    
    func configureSubViewController(with index: Int ) {
           guard index < navigationControllers.count else { return }
           let viewController = navigationControllers[index]
           
           guard currentViewController != viewController else {
               currentViewController?.popToRootViewController(animated: false)
               return
           }
           
           if let oldViewController = currentViewController {
               oldViewController.willMove(toParent: nil)
               oldViewController.view.removeFromSuperview()
               oldViewController.removeFromParent()
           }
           
           images.enumerated().forEach { (subIndex, imageView) in
               imageView.image = imageView.image?.withTintColor(index == subIndex ? Colors.text.withAlphaComponent(0.5) : Colors.text)
           }
           
           titles.enumerated().forEach { (subIndex, labelView) in
               labelView.textColor = index == subIndex ? Colors.text.withAlphaComponent(0.5)  : Colors.text
           }
           
           currentTabIndex = index
           addChild(viewController)
           viewController.view.frame = mainScreenView.bounds
            mainScreenView.addSubview(viewController.view)
           viewController.didMove(toParent: self)
       }
    
}

//MARK: Public
extension TabBarViewController {
    func changeTab(with index: Int) {
        configureSubViewController(with: index)
    }
}

//MARK: Action
private extension TabBarViewController {
    @IBAction func changeTabAction(_ sender: UIButton) {
        changeTab(with: sender.tag)
    }
}
