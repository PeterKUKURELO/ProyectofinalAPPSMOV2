import UIKit

final class AvatarGradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        // Gradiente más intenso arriba, más claro abajo
        gradientLayer.colors = [
            UIColor(red: 0.95, green: 0.82, blue: 0.98, alpha: 1).cgColor,
            UIColor(red: 0.99, green: 0.95, blue: 1.00, alpha: 1).cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 0.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds

        // Circular (puedes usar 1000 si quieres literal Figma)
        layer.cornerRadius = bounds.width / 2
        clipsToBounds = true
    }
}
