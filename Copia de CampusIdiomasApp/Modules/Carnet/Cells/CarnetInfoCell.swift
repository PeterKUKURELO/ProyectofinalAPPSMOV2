import UIKit

final class CarnetInfoCell: UITableViewCell {

    static let identifier = "CarnetInfoCell"

    // MARK: - Outlets (conecta desde CarnetInfoCell.xib)

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var careerLabel: UILabel!

    @IBOutlet private weak var campusIconImageView: UIImageView!
    @IBOutlet private weak var campusLabel: UILabel!

    @IBOutlet private weak var codeIconImageView: UIImageView!
    @IBOutlet private weak var codeLabel: UILabel!

    @IBOutlet private weak var emailButton: UIButton!

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

        assert(nameLabel != nil, "❌ nameLabel NO conectado")
          assert(careerLabel != nil, "❌ careerLabel NO conectado")
          assert(campusIconImageView != nil, "❌ campusIconImageView NO conectado")
          assert(campusLabel != nil, "❌ campusLabel NO conectado")
          assert(codeIconImageView != nil, "❌ codeIconImageView NO conectado")
          assert(codeLabel != nil, "❌ codeLabel NO conectado")
          assert(emailButton != nil, "❌ emailButton NO conectado")
        
        // Nombre
        nameLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.textColor = .systemPurple

        // Carrera
        careerLabel.font = UIFont.systemFont(ofSize: 14.5, weight: .semibold)
        careerLabel.textAlignment = .center
        careerLabel.numberOfLines = 2
        careerLabel.textColor = .label

        // Iconos
        campusIconImageView.image = UIImage(systemName: "mappin.and.ellipse")
        campusIconImageView.tintColor = .systemPurple

        codeIconImageView.image = UIImage(systemName: "flag.fill")
        codeIconImageView.tintColor = .systemPurple

        // Labels meta
        [campusLabel, codeLabel].forEach {
            $0?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
            $0?.textColor = .label
            $0?.numberOfLines = 1
        }

        // Botón email (pill) con iOS 15+ Configuration
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .systemPurple
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14)

        // Fuente (con attributedTitle vacío por defecto)
        config.attributedTitle = AttributedString(
            "",
            attributes: AttributeContainer([
                .font: UIFont.systemFont(ofSize: 14, weight: .semibold)
            ])
        )

        emailButton.configuration = config
        emailButton.layer.cornerRadius = 10
        emailButton.clipsToBounds = true
    }

    // MARK: - Configure

    func configure(fullName: String, career: String, campus: String, code: String, email: String) {
        nameLabel.text = fullName.uppercased()
        careerLabel.text = career.uppercased()
        campusLabel.text = campus
        codeLabel.text = code

        var config = emailButton.configuration
        config?.title = email
        emailButton.configuration = config
    }

    // MARK: - Actions

    @IBAction private func didTapEmail(_ sender: UIButton) {
        // ✅ Con UIButtonConfiguration el título está en configuration
        guard let email = sender.configuration?.title, !email.isEmpty else { return }

        UIPasteboard.general.string = email
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
