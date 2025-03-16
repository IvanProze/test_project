import UIKit
import AppResource

final class SettingsViewController: UIViewController {
    // MARK: - Properties
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var tabelView: UITableView!
    private var settingList = SettingsEnum.sections
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
}

// MARK: - Private
private extension SettingsViewController {
    func setupScreen() {
        configureTableView()
        configureTitle()
    }
    
    func configureTableView() {
        tabelView.dataSource = self
        tabelView.delegate = self
        
        tabelView.showsVerticalScrollIndicator = false
        tabelView.showsHorizontalScrollIndicator = false
        
        tabelView.register(SettingTableViewCell.nib, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifier)
        
        let bottomTabel = NavigationService.shared.tabBarViewController?.height
        tabelView.contentInset = UIEdgeInsets(top: .zero, left: .zero, bottom: bottomTabel ?? 0, right: .zero)
    }
    
    func configureTitle() {
        titleLabel.text = Strings.Setting.title
        titleLabel.font = Fonts.konkhmerSleokchherRegular(32)
        titleLabel.textColor = Colors.text
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = settingList[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifier, for: indexPath) as! SettingTableViewCell
        cell.config(title: model.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = settingList[indexPath.section][indexPath.row]
        handleSettingSelection(model)
    }
    
    private func handleSettingSelection(_ model: SettingsEnum) {
        switch model {
        case .share:
            print("Share App")
        case .rateUs:
            print("Rate Us")
        case .contact:
            print("Contact Us")
        case .restore:
            print("Restore Purchases")
        case .terms:
            print("Terms of Use")
        case .privacy:
            print("Privacy Policy")
        default:
            break
        }
    }
}
