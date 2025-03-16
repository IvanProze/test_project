import UIKit
import AppResource
import SwifterSwift

final class ResultViewController: UIViewController {
    //MARK: Property
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var repeatLabel: UILabel!
    
    @IBOutlet private weak var repeatButton: UIButton!
    @IBOutlet private weak var closeButton: UIButton!
    
    @IBOutlet private weak var repeatView: UIView!
    @IBOutlet private weak var messageCloudView: UIView!
    
    @IBOutlet private weak var textLabel: UILabel!
    
    @IBOutlet private weak var repeatImage: UIImageView!
    @IBOutlet private weak var mainImage: UIImageView!
    
    @IBOutlet private weak var mainImageToSafeBottomConstraint: NSLayoutConstraint!
    
    private var text: String?
    private let typeAnimal: Animal
    private var tailView: MessageCloudView?
    private var file: URL
    
    //MARK: Init
    init(text: String?, typeAnimal: Animal, file: URL) {
        self.file = file
        self.text = text
        self.typeAnimal = typeAnimal
        super.init(nibName: "ResultViewController", bundle: .module)
    }
    
    //MARK: LifeCell
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Private
private extension ResultViewController {
    func setupScreen() {
        mainImageToSafeBottomConstraint.constant = NavigationService.shared.tabBarViewController?.height ?? 0
        setLabel()
        setImage()
        setButton()
        Colors.gradientBackground(view: view)
    }
    
    func setView() {
        repeatView.backgroundColor = Colors.sky
        repeatView.layer.cornerRadius = 16
        
        messageCloudView.backgroundColor = .clear
        messageCloudView.layer.cornerRadius = 16
        
        guard let resetImageFrame = mainImage?.frame else { return }
        let topCenter = CGPoint(x: resetImageFrame.maxX / 1.32  , y: resetImageFrame.minY - 20)
        
        tailView = MessageCloudView(tailEnd: topCenter, referenceView: messageCloudView, color: Colors.sky.cgColor)
        
        view.insertSubview(tailView ?? UIView(), belowSubview: messageCloudView)
        guard text == nil else { return }
        tailView?.hideTail()
        messageCloudView.isHidden = true
        repeatView.isHidden = false
    }
    
    func setButton() {
        closeButton.layer.cornerRadius = closeButton.width / 2
        closeButton.backgroundColor = Colors.background
        closeButton.setImage(Images.close.withTintColor(Colors.text), for: .normal)
    }
    
    func setLabel() {
        titleLabel.text = Strings.Home.result
        titleLabel.textColor = Colors.text
        titleLabel.font = Fonts.konkhmerSleokchherRegular(32)
        
        repeatLabel.text = Strings.Home.repeat_
        repeatLabel.textColor = Colors.text
        repeatLabel.font = Fonts.konkhmerSleokchherRegular(12)
        
        textLabel.textColor = Colors.text
        textLabel.font = Fonts.konkhmerSleokchherRegular(12)
        textLabel.text = text
    }
    
    func setImage() {
        repeatImage.image = Images.repeat_.withTintColor(Colors.text)
        mainImage.image = typeAnimal.imag
    }
    
    func requestTranslate() {
        repeatButton.isUserInteractionEnabled = false
        repeatImage.isHidden = true
        repeatLabel.text = Strings.Home.processOfTranslation
        TranslateManager.shared.translateFromPetToHuman(file: file) {[weak self] result in
            guard let self = self else { return }
            if result != nil {
                text = result
                textLabel.text = text
                tailView?.showTail()
                messageCloudView.isHidden = false
                repeatView.isHidden = true
            }
            repeatButton.isUserInteractionEnabled = true
            repeatLabel.text = Strings.Home.repeat_
            repeatImage.isHidden = false
        }
    }
}

//MARK: Action
private extension ResultViewController {
    @IBAction func repeatAction(_ sender: Any) {
        requestTranslate()
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true)
    }
}
