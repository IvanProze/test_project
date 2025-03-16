import UIKit
import AppResource

final class OptionCollectionViewCell: UICollectionViewCell {
    public static let nib = UINib(nibName: "OptionCollectionViewCell", bundle: .module)
    public static let reuseIdentifier = "OptionCollectionViewCell"

    @IBOutlet private var animalViews: [UIView]!
    @IBOutlet private weak var dogImage: UIImageView!
    @IBOutlet private weak var catImage: UIImageView!
        
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView?.backgroundColor = .clear
        contentView.layer.cornerRadius = 16
        contentView.clipsToBounds = true

        layer.shadowColor = Colors.shadow.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
    }
}

extension OptionCollectionViewCell {
    func config() {
        catImage.image = Animal.cat.imag
        dogImage.image = Animal.dog.imag
        
        let backgroundColors = [Colors.sky, Colors.lightGreen]
        animalViews.forEach { view in
            view.backgroundColor = backgroundColors[view.tag]
            view.layer.cornerRadius = 8
            view.layer.shadowRadius = 40
            view.layer.shadowColor = Colors.subShadow.cgColor
            view.layer.shadowOpacity = 0.10
            view.layer.shadowOffset = CGSize(width: 0, height: 20)
            view.layer.masksToBounds = false
        }
        
        setImge(index: TranslateManager.shared.selectedAnimal == .cat ? 1 : 0 )
    }
}

private extension OptionCollectionViewCell {
    func setImge(index: Int) {
        TranslateManager.shared.selectedAnimal = index == 1 ? .cat : .dog
        animalViews.forEach { view in
            view.alpha = index == view.tag ? 1 : 0.6
        }
    }
}

private extension OptionCollectionViewCell {
    @IBAction func setAnimalAction(_ sender: UIButton) {
        setImge(index: sender.tag)
    }
}
