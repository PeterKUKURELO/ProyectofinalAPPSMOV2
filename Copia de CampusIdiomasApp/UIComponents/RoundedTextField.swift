import UIKit

final class RoundedTextField: UITextField {

    // Padding base
    private let baseInsets = UIEdgeInsets(top: 0, left: DT.Size.fieldTextInsetLeft, bottom: 0, right: DT.Size.fieldTextInsetLeft)

    // Para el ojo (password)
    private let rightContainer = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 49))
    private var rightButton: UIButton?

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = DT.Color.fieldFill
        layer.cornerRadius = DT.Size.fieldCornerRadius
        layer.borderWidth = DT.Size.fieldBorderWidth
        layer.borderColor = DT.Color.fieldBorder.cgColor

        font = DT.Font.field
        textColor = DT.Color.fieldText
        tintColor = DT.Color.fieldText

        autocorrectionType = .no
        spellCheckingType = .no
        clearButtonMode = .never

        addTarget(self, action: #selector(focusOn), for: .editingDidBegin)
        addTarget(self, action: #selector(focusOff), for: .editingDidEnd)
    }

    func setPlaceholder(_ text: String) {
        attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .font: DT.Font.field,
                .foregroundColor: DT.Color.placeholder
            ]
        )
    }

    func enableRightPadding() {
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            spacer.widthAnchor.constraint(equalToConstant: 44),
            spacer.heightAnchor.constraint(equalToConstant: 49)
        ])

        rightView = spacer
        rightViewMode = .always
    }

    func enablePasswordToggle() {
        isSecureTextEntry = true

        // Contenedor con tamaño fijo (no depende del frame del textfield)
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = DT.Color.fieldText.withAlphaComponent(0.6)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.addTarget(self, action: #selector(togglePassword), for: .touchUpInside)

        container.addSubview(button)

        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: 44),
            container.heightAnchor.constraint(equalToConstant: 49),

            button.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 22),
            button.heightAnchor.constraint(equalToConstant: 22)
        ])

        rightView = container
        rightViewMode = .always
        rightButton = button
    }


    @objc private func togglePassword() {
        let wasFirstResponder = isFirstResponder
        isSecureTextEntry.toggle()

        let icon = isSecureTextEntry ? "eye" : "eye.slash"
        rightButton?.setImage(UIImage(systemName: icon), for: .normal)

        // Fix cursor al alternar secureTextEntry
        if wasFirstResponder {
            _ = becomeFirstResponder()
        }
    }
    @objc private func focusOn() {
        layer.borderColor = DT.Color.fieldBorderFocus.cgColor
    }

    @objc private func focusOff() {
        layer.borderColor = DT.Color.fieldBorder.cgColor
    }

    // MARK: - Insets
    private func resolvedInsets() -> UIEdgeInsets {
        var insets = baseInsets
        if rightViewMode == .always {
            insets.right = 44 + DT.Size.fieldTextInsetLeft
        }
        return insets
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: resolvedInsets())
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: resolvedInsets())
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: resolvedInsets())
    }
}
