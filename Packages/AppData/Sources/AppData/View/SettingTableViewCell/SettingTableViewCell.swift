import UIKit
import AppResource

final class SettingTableViewCell: UITableViewCell {
    public static let nib = UINib(nibName: "SettingTableViewCell", bundle: .module)
    public static let reuseIdentifier = "SettingTableViewCell"
    
    @IBOutlet private weak var mainView: UIView!
    @IBOutlet private weak var arrowImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func config(title: String) {
        titleLabel.text = title
        titleLabel.textColor = Colors.text
        titleLabel.font = Fonts.konkhmerSleokchherRegular(16)
        
        arrowImage.image = Images.arrowRight
        
        mainView.layer.cornerRadius = 20
        mainView.backgroundColor = Colors.sky
    }
}
