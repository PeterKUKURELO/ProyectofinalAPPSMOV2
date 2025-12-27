import UIKit

final class CarnetClockCell: UITableViewCell {

    static let identifier = "CarnetClockCell"

    // MARK: - Outlets (conectar desde XIB)

    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeContainerView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!

    // MARK: - Private

    private let timeGradientLayer = CAGradientLayer()

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear

        setupUI()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutTimeGradient()
    }

    // MARK: - Setup UI

    private func setupUI() {

        // Fecha
        dateLabel.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        dateLabel.textColor = .secondaryLabel
        dateLabel.textAlignment = .center
        dateLabel.numberOfLines = 1

        // Contenedor de hora
        timeContainerView.layer.cornerRadius = 10
        timeContainerView.clipsToBounds = true

        // Hora (monoespaciado)
        timeLabel.font = UIFont.monospacedDigitSystemFont(
            ofSize: 34,
            weight: .bold
        )
        timeLabel.textAlignment = .center
        timeLabel.textColor = .label
        timeLabel.numberOfLines = 1

        // Gradiente suave (mock)
        timeGradientLayer.colors = [
            UIColor(red: 0.973, green: 0.863, blue: 0.976, alpha: 1).cgColor, // F8DCF9
            UIColor.white.cgColor
        ]
        timeGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        timeGradientLayer.endPoint   = CGPoint(x: 1.0, y: 0.5)

        timeContainerView.layer.insertSublayer(
            timeGradientLayer,
            at: 0
        )
    }

    private func layoutTimeGradient() {
        timeGradientLayer.frame = timeContainerView.bounds
    }

    // MARK: - Configure

    func configure(dateText: String, timeText: String) {
        dateLabel.text = dateText
        timeLabel.text = timeText
    }
}
