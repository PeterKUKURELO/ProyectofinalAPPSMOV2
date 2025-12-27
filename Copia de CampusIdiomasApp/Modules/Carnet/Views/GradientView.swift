import UIKit

final class GradientView: UIView {

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
        // Top: F8DCF9, Bottom: FFFFFF
        gradientLayer.colors = [
            UIColor(red: 0.973, green: 0.863, blue: 0.976, alpha: 1).cgColor,
            UIColor.white.cgColor
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        gradientLayer.frame = bounds

        // 🔥 “1000” estilo Figma
        layer.cornerRadius = 1000
        clipsToBounds = true
    }
}
