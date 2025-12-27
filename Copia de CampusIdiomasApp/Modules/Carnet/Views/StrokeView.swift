import UIKit

final class StrokeView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = 1000
        layer.borderWidth = 2
        layer.borderColor = UIColor(
            red: 0.807, green: 0.016, blue: 0.824, alpha: 0.05
        ).cgColor

        backgroundColor = .clear
        clipsToBounds = true
    }
}
