import UIKit

final class CarnetOfflineBannerCell: UITableViewCell {

    static let identifier = "CarnetOfflineBannerCell"

    // MARK: - Outlets (conectar desde XIB)

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var messageLabel: UILabel!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupUI()
    }

    // MARK: - Setup

    private func setupUI() {

        // Fondo tipo banner
        contentView.backgroundColor =
            UIColor.black.withAlphaComponent(0.85)
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        // Icono
        iconImageView.image = UIImage(systemName: "info.circle")
        iconImageView.tintColor = .white
        iconImageView.contentMode = .scaleAspectFit

        // Texto
        messageLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        messageLabel.textColor = .white
        messageLabel.numberOfLines = 0
    }

    // MARK: - Configure

    func configure(message: String, isVisible: Bool) {
        messageLabel.text = message
        isHidden = !isVisible
    }
}
