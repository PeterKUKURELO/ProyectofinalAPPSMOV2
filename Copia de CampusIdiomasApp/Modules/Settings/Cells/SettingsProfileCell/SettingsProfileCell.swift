import UIKit

final class SettingsProfileCell: UITableViewCell {

    static let identifier = "SettingsProfileCell"

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        // Card
        cardView.layer.cornerRadius = 18
        cardView.layer.borderWidth = 1.5
        cardView.layer.borderColor = UIColor(
            red: 147/255, green: 2/255, blue: 150/255, alpha: 1
        ).cgColor
        cardView.backgroundColor = UIColor(
            red: 250/255, green: 242/255, blue: 250/255, alpha: 1
        )

        // Avatar
        avatarImageView.layer.cornerRadius = 28
        avatarImageView.clipsToBounds = true
        avatarImageView.contentMode = .scaleAspectFill

        // Textos
        titleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        titleLabel.textColor = UIColor(
            red: 147/255, green: 2/255, blue: 150/255, alpha: 1
        )

        subtitleLabel.font = .systemFont(ofSize: 16, weight: .regular)
        subtitleLabel.textColor = .black
    }

    func configure(name: String) {
        titleLabel.text = "Hola, \(name)"
        subtitleLabel.text = "Bienvenido a CIC APP"
        avatarImageView.image = UIImage(named: "profile_placeholder") // tu asset
    }
}
