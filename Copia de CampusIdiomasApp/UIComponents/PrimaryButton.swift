import UIKit

final class PrimaryButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        layer.cornerRadius = DT.Size.primaryButtonCornerRadius
        layer.masksToBounds = true

        backgroundColor = DT.Color.primaryButtonFill

        setTitleColor(DT.Color.buttonText, for: .normal)
        titleLabel?.font = DT.Font.button
        titleLabel?.textAlignment = .center
    }

    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.6
        }
    }
}
