import UIKit
import AVFAudio
import AppResource

final class HomeViewController: UIViewController {
    //MARK: Property
    //state1
    @IBOutlet weak var state1View: UIView!
    @IBOutlet weak var translateToLabel: UILabel!
    @IBOutlet weak var translateFromLabel: UILabel!
    @IBOutlet weak var reversaImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    //state2
    @IBOutlet weak var state2View: UIView!
    @IBOutlet weak var processLabel: UILabel!
    
    //Global
    @IBOutlet weak var animalTranslationImage: UIImageView!
    
    //MARK: LifeCell
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
}

//MARK: Private
private extension HomeViewController {
    func setupScreen() {
        NotificationCenter.default.addObserver(self, selector: #selector(setAnimal), name: .setAnimal, object: nil)
        setupCollectionViewLayout()
        reversaImage.image = Images.reversal.withTintColor(Colors.text)
        animalTranslationImage.image = TranslateManager.shared.selectedAnimal.imag
        setLabels()
    }
    
    func setupCollectionViewLayout() {
        collectionView.register(MicroCollectionViewCell.nib, forCellWithReuseIdentifier: MicroCollectionViewCell.reuseIdentifier)
        collectionView.register(OptionCollectionViewCell.nib, forCellWithReuseIdentifier: OptionCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        collectionView.clipsToBounds = false
    }
    
    @objc func setAnimal() {
        animalTranslationImage.image = TranslateManager.shared.selectedAnimal.imag
    }
    
    func setLabels() {
        titleLabel.text = Strings.Home.title
        titleLabel.font = Fonts.konkhmerSleokchherRegular(32)
        titleLabel.textColor = Colors.text
        
        translateFromLabel.text = TranslateManager.shared.translationMode != .toHuman ? Strings.Home.human.uppercased() : Strings.Home.pet.uppercased()
        translateToLabel.text = TranslateManager.shared.translationMode != .toHuman ? Strings.Home.pet.uppercased() : Strings.Home.human.uppercased()
        
        processLabel.text = Strings.Home.processOfTranslation
        [translateFromLabel, translateToLabel, processLabel].forEach({
            $0.textColor = Colors.text
            $0.font = Fonts.konkhmerSleokchherRegular(16)
        })
    }
    
    func calculateLayoutValues() -> (firstWidth: CGFloat, secondWidth: CGFloat, interItemSpacing: CGFloat) {
        let availableWidth = UIScreen.main.bounds.width
        let referenceScreenWidth: CGFloat = 390
        let referenceFirstWidth: CGFloat = 178
        let referenceSecondWidth: CGFloat = 107
        let scaleFactor = availableWidth / referenceScreenWidth
        let firstWidth = referenceFirstWidth * scaleFactor
        let secondWidth = referenceSecondWidth * scaleFactor
        let spacing = availableWidth - (firstWidth + secondWidth) - 35 * 2
        return (firstWidth, secondWidth, spacing)
    }
    
    func startRcoding() {
        AudioRecorderManager.shared.checkMicrophonePermission { granted in
            if granted {
                AudioRecorderManager.shared.startRecording()
            }
        }
    }
    
    func stopRcoding() {
        let filePath = URL(fileURLWithPath: AudioRecorderManager.shared.stopRecording())
        guard TranslateManager.shared.translationMode == .toHuman else {
            NavigationService.shared.presentFeatureComingSoonAlert()
            return
        }
        state1View.isHidden = true
        state2View.isHidden = false
        TranslateManager.shared.translateFromPetToHuman(file: filePath) {[weak self] text in
            guard let self = self else { return }
            NavigationService.shared.presentResultScreen(text: text, typeAnimal: TranslateManager.shared.selectedAnimal, file: filePath)
            state1View.isHidden = false
            state2View.isHidden = true
        }
    }
}

//MARK: UICollectionViewDataSource & UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MicroCollectionViewCell.reuseIdentifier, for: indexPath) as? MicroCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.config(delegate: self)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OptionCollectionViewCell.reuseIdentifier, for: indexPath) as? OptionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.config()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layoutValues = calculateLayoutValues()
        if indexPath.item == 0 {
            return CGSize(width: layoutValues.firstWidth, height: collectionView.bounds.height)
        } else {
            return CGSize(width: layoutValues.secondWidth, height: collectionView.bounds.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let layoutValues = calculateLayoutValues()
        return layoutValues.interItemSpacing
    }
    
    func reversa() {
        let translationMode = TranslateManager.shared.translationMode
        TranslateManager.shared.translationMode = translationMode == .toHuman ? .toPet : .toHuman
        translateToLabel.text = (translationMode == .toHuman ? Strings.Home.pet : Strings.Home.human).uppercased()
        translateFromLabel.text = (translationMode != .toHuman ? Strings.Home.pet : Strings.Home.human).uppercased()
    }
}

//MARK: Action
private extension HomeViewController {
    @IBAction func reversaAction(_ sender: Any) {
        reversa()
    }
}

//MARK: MicroCollectionViewCellDelegate
extension HomeViewController: MicroCollectionViewCellDelegate {
    func startStop(isStart: Bool) {
        if isStart {
            startRcoding()
        } else {
            stopRcoding()
        }
    }
}
