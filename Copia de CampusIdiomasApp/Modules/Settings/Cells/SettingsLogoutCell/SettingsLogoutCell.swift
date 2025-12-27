import UIKit

final class SettingsLogoutCell: UITableViewCell {

    static let identifier = "SettingsLogoutCell"

    @IBOutlet private weak var buttonView: UIView!
    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    private var onLogout: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupUI()
    }

    private func setupUI() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear

        // Botón
        buttonView.layer.cornerRadius = 18
        buttonView.backgroundColor = UIColor(
            red: 147/255, green: 2/255, blue: 150/255, alpha: 1
        )

        // Icono
        iconImageView.image = UIImage(systemName: "arrow.right.square")
        iconImageView.tintColor = .white

        // Texto
        titleLabel.text = "Cerrar sesión"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
    }

    func configure(onLogout: @escaping () -> Void) {
        self.onLogout = onLogout
    }

    @IBAction private func logoutTapped() {
        onLogout?()
    }
}
