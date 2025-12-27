import UIKit

final class CourseCardCollectionCell: UICollectionViewCell {

    static let identifier = "CourseCardCollectionCell"

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var thumbnailImageView: UIImageView!

    private let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        // Card
        containerView.layer.cornerRadius = 24
        containerView.clipsToBounds = true

        // Gradient
        setupGradient()

        // Thumbnail
        thumbnailImageView.layer.cornerRadius = 8
        thumbnailImageView.clipsToBounds = true
        thumbnailImageView.contentMode = .scaleAspectFill

        // Textos
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 3
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)

        statusLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        statusLabel.font = .systemFont(ofSize: 18, weight: .regular)

        // Fondo
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
        gradientLayer.cornerRadius = containerView.layer.cornerRadius
    }

    private func setupGradient() {
        // 0%: #8A018D
        let start = UIColor(red: 138/255, green: 1/255, blue: 141/255, alpha: 1).cgColor
        // 100%: #D605DA
        let end = UIColor(red: 214/255, green: 5/255, blue: 218/255, alpha: 1).cgColor

        gradientLayer.colors = [start, end]

        // "Lineal" horizontal (izq → der). Si lo quieres vertical, cambia los puntos.
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        if gradientLayer.superlayer == nil {
            containerView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    func configure(with item: CourseItem) {
        titleLabel.text = item.title
        statusLabel.text = item.status

        if let name = item.imageName {
            thumbnailImageView.image = UIImage(named: name)
        } else {
            thumbnailImageView.image = nil
        }
    }
}
