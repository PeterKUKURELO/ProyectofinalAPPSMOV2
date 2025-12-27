import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var emailTextField: RoundedTextField!
    @IBOutlet private weak var passwordTextField: RoundedTextField!
    @IBOutlet private weak var loginButton: PrimaryButton!

    @IBOutlet private weak var connectWithLabel: UILabel!
    @IBOutlet private weak var googleButton: UIButton!

    // MARK: - Properties
    private let authService = AuthService()
    private var isLoading = false

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureTextFields()
        configureKeyboardDismiss()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Evita animaciones implícitas del layer (previene NaN)
        CATransaction.begin()
        CATransaction.setDisableActions(true)

        googleButton.layer.cornerRadius = DT.Size.googleButtonCornerRadius
        googleButton.clipsToBounds = true

        CATransaction.commit()
    }

    // MARK: - UI Configuration
    private func configureUI() {
        // Logo
        logoImageView.image = UIImage(named: "LogoCICcompleto")
        logoImageView.contentMode = .scaleAspectFit

        // Title
        titleLabel.text = "Acceder a su cuenta"
        titleLabel.textColor = DT.Color.titleText
        titleLabel.font = DT.Font.title

        // Login Button
        loginButton.setTitle("Iniciar Sesión", for: .normal)

        // Connect With
        connectWithLabel.text = "- O CONÉCTESE CON -"
        connectWithLabel.textColor = .white
        connectWithLabel.font = DT.Font.connectWith
        connectWithLabel.textAlignment = .center

        // Google Button
        configureGoogleButton()
    }

    private func configureGoogleButton() {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "GoogleIcon")
        config.imagePlacement = .all
        config.contentInsets = NSDirectionalEdgeInsets(top: 11, leading: 11, bottom: 11, trailing: 11)

        googleButton.configuration = config
        googleButton.backgroundColor = DT.Color.googleFill
        googleButton.layer.borderWidth = 1
        googleButton.layer.borderColor = DT.Color.googleBorder.cgColor
    }

    private func configureTextFields() {
        emailTextField.setPlaceholder("Correo electrónico")
        emailTextField.enableRightPadding()

        passwordTextField.setPlaceholder("Contraseña")
        passwordTextField.enablePasswordToggle()

        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.textContentType = .username
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self

        passwordTextField.autocapitalizationType = .none
        passwordTextField.autocorrectionType = .no
        passwordTextField.textContentType = .password
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
    }

    private func configureKeyboardDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - Actions
    @IBAction private func didTapLogin(_ sender: UIButton) {
        view.endEditing(true)
        guard !isLoading else { return }

        let email = (emailTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text ?? ""

        guard isValidEmail(email) else {
            showAlert(title: "Error", message: "Ingrese un correo válido.")
            return
        }

        guard password.count >= 6 else {
            showAlert(title: "Error", message: "La contraseña debe tener al menos 6 caracteres.")
            return
        }

        setLoading(true)

        let request = LoginRequest(email: email, password: password)
        authService.login(request: request) { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.setLoading(false)

                switch result {
                case .success:
                    UserDefaults.standard.set(true, forKey: DefaultsKeys.isLoggedIn)

                    let hasSeen = UserDefaults.standard.bool(forKey: DefaultsKeys.hasSeenOnboarding)
                    if hasSeen {
                        AppRouter.shared.showMainTab()
                    } else {
                        AppRouter.shared.showOnboarding()
                    }

                case .failure(let error):
                    self.showAlert(
                        title: "No se pudo iniciar sesión",
                        message: error.localizedDescription
                    )
                }
            }
        }
    }

    @IBAction private func didTapGoogle(_ sender: UIButton) {
        showAlert(
            title: "Info",
            message: "Google Sign-In se implementará después. Por ahora es maqueta."
        )
    }

    // MARK: - Helpers
    private func setLoading(_ loading: Bool) {
        isLoading = loading

        loginButton.isEnabled = !loading
        googleButton.isEnabled = !loading
        emailTextField.isEnabled = !loading
        passwordTextField.isEnabled = !loading

        loginButton.setTitle(
            loading ? "Ingresando..." : "Iniciar Sesión",
            for: .normal
        )
    }

    private func isValidEmail(_ email: String) -> Bool {
        email.contains("@") && email.contains(".") && email.count >= 6
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField === passwordTextField {
            didTapLogin(loginButton)
        }
        return true
    }
}
