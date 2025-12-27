import UIKit

final class SettingsItemCell: UITableViewCell {

    static let identifier = "SettingsItemCell"

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var chevronImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        // Card
        cardView.layer.cornerRadius = 16
        cardView.backgroundColor = UIColor(
            red: 250/255, green: 242/255, blue: 250/255, alpha: 1
        )

        // Icon
        iconImageView.tintColor = UIColor(
            red: 147/255, green: 2/255, blue: 150/255, alpha: 1
        )
        iconImageView.contentMode = .scaleAspectFit

        // Chevron
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = UIColor(
            red: 147/255, green: 2/255, blue: 150/255, alpha: 1
        )

        // Text
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .black

        subtitleLabel.font = .systemFont(ofSize: 15)
        subtitleLabel.textColor = UIColor.black.withAlphaComponent(0.7)
        subtitleLabel.numberOfLines = 2
    }

    func configure(with item: SettingsItem) {
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        iconImageView.image = UIImage(named: item.iconName)
    }
}
