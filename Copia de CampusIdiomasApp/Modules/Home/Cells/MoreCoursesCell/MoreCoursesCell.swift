import UIKit

final class MoreCoursesCell: UITableViewCell {

    static let identifier = "MoreCoursesCell"

    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!

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
        cardView.clipsToBounds = true
        cardView.backgroundColor = .white

        // Texto
        titleLabel.font = .systemFont(ofSize: 14, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center

        // Sombra (en contentView, no en cardView)
        applyShadow()
    }

    private func applyShadow() {
        contentView.layer.shadowColor = UIColor(
            red: 148/255,
            green: 165/255,
            blue: 228/255,
            alpha: 0.15
        ).cgColor

        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 5)
        contentView.layer.shadowRadius = 15
        contentView.layer.masksToBounds = false
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        // Mejora performance y precisión de la sombra
        contentView.layer.shadowPath = UIBezierPath(
            roundedRect: cardView.frame,
            cornerRadius: cardView.layer.cornerRadius
        ).cgPath
    }

    func configure(extraCount: Int) {
        titleLabel.text = "+ \(extraCount) cursos"
    }
}
