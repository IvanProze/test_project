import UIKit
import AppResource
import SDWebImage

protocol MicroCollectionViewCellDelegate {
    func startStop(isStart: Bool)
}

final class MicroCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var soundWaveImage: SDAnimatedImageView!
    @IBOutlet private weak var mainLabel: UILabel!
    @IBOutlet private weak var microImage: UIImageView!
    
    private var isStart: Bool {
        return !AudioRecorderManager.shared.isRecordingInProgress()
    }
    public static let nib = UINib(nibName: "MicroCollectionViewCell", bundle: .module)
    public static let reuseIdentifier = "MicroCollectionViewCell"
    private var delegate: MicroCollectionViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainLabel.text = Strings.Home.startSpeak
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView?.backgroundColor = .clear
        contentView.backgroundColor = Colors.background
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true

        layer.shadowColor = Colors.shadow.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}

extension MicroCollectionViewCell {
    public func config(delegate: MicroCollectionViewCellDelegate) {
        self.delegate = delegate
        microImage.image = Images.microphone.withTintColor(Colors.text)
        mainLabel.text = Strings.Home.startSpeak
        mainLabel.font = Fonts.konkhmerSleokchherRegular(16)
        mainLabel.autoresizesSubviews = true
        mainLabel.textColor = Colors.text
        soundWaveImage.sd_setImage(with: Animations.wave.path, placeholderImage: Images.microphone.withTintColor(Colors.text))
    }
}

private extension MicroCollectionViewCell {
    @IBAction func startStopAction(_ sender: Any) {
        mainLabel.text = isStart ?  Strings.Home.recording : Strings.Home.startSpeak
        microImage.isHidden = isStart
        soundWaveImage.isHidden = !isStart
        delegate?.startStop(isStart: isStart)
    }
}
