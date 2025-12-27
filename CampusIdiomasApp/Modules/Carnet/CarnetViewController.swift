import UIKit

final class CarnetViewController: UIViewController {

    // MARK: - Header
    @IBOutlet private weak var headerBackgroundImageView: UIImageView!
    @IBOutlet private weak var profileImageView: UIImageView!

    // MARK: - User Info
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var careerLabel: UILabel!
    @IBOutlet private weak var campusLabel: UILabel!
    @IBOutlet private weak var codeLabel: UILabel!
    @IBOutlet private weak var emailButton: UIButton!

    // MARK: - Date & Time
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeContainerView: UIView!
    @IBOutlet private weak var timeLabel: UILabel!

    // MARK: - Demo data
    private let fullName = "JUAN CARLOS PÉREZ GÓMEZ"
    private let career = "COMPUTACIÓN E INFORMÁTICA"
    private let campus = "Campus San Carlos"
    private let code = "E2023743"
    private let email = "e2023743@cic.edu.pe"

    private var timer: Timer?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupUI()
        bindData()
        startClock()
    }

    deinit {
        timer?.invalidate()
    }
    private func setupNavigation() {
        title = "Carnet"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    private func setupUI() {

        view.backgroundColor = .white

        // Header
        headerBackgroundImageView.image = UIImage(named: "backgroundimg")
        headerBackgroundImageView.contentMode = .scaleAspectFill
        headerBackgroundImageView.clipsToBounds = true

        profileImageView.layer.cornerRadius = 60
        profileImageView.layer.borderWidth = 4
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.clipsToBounds = true
        profileImageView.image = UIImage(named: "profile")

        // Name
        nameLabel.textColor = UIColor.systemPurple
        nameLabel.font = .systemFont(ofSize: 22, weight: .bold)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2

        // Career
        careerLabel.textColor = .black
        careerLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        careerLabel.textAlignment = .center

        // Campus & Code
        [campusLabel, codeLabel].forEach {
            $0?.textColor = UIColor.black.withAlphaComponent(0.75)
            $0?.font = .systemFont(ofSize: 15, weight: .medium)
            $0?.textAlignment = .center
        }

        // Email button
        emailButton.setTitleColor(.white, for: .normal)
        emailButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        emailButton.backgroundColor = UIColor.systemPurple
        emailButton.layer.cornerRadius = 12
        emailButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

        // Date
        dateLabel.textColor = .gray
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textAlignment = .center

        // Time
        timeContainerView.backgroundColor = UIColor.systemPurple.withAlphaComponent(0.15)
        timeContainerView.layer.cornerRadius = 16
        timeContainerView.clipsToBounds = true

        timeLabel.font = .monospacedDigitSystemFont(ofSize: 32, weight: .bold)
        timeLabel.textAlignment = .center
    }
    private func bindData() {
        nameLabel.text = fullName
        careerLabel.text = career
        campusLabel.text = campus
        codeLabel.text = code
        emailButton.setTitle(email, for: .normal)

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        formatter.dateFormat = "EEEE, dd MMM yyyy"
        dateLabel.text = formatter.string(from: Date()).capitalized
    }

    private func startClock() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            self?.timeLabel.text = formatter.string(from: Date())
        }
    }


}
