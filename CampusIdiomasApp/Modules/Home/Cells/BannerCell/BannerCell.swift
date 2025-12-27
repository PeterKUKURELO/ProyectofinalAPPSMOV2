import UIKit

final class BannerCell: UITableViewCell {

    static let identifier = "BannerCell"

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var ingresarButton: UIButton!
    @IBOutlet private weak var studentImageView: UIImageView!

    private let gradientLayer = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        selectionStyle = .none

        setupUI()
        setupGradient()
        configureTitle()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
    }

    private func setupUI() {
        containerView.layer.cornerRadius = 24
        containerView.clipsToBounds = true

        subtitleLabel.text = "Tu acceso rapido al campus"
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.9)

        // BOTÓN
        ingresarButton.setTitle("INGRESAR", for: .normal)
        ingresarButton.setTitleColor(.white, for: .normal)
        ingresarButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        ingresarButton.backgroundColor = UIColor(
            red: 0.65,
            green: 0.18,
            blue: 0.70,
            alpha: 1
        )
        ingresarButton.layer.cornerRadius = 11.8
        ingresarButton.clipsToBounds = true

        // IMAGEN
        studentImageView.image = UIImage(named: "BannerStudent")
        studentImageView.contentMode = .scaleAspectFit
    }


    private func configureTitle() {
        let carnet = NSAttributedString(
            string: "Carnet ",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 20, weight: .regular)
            ]
        )

        let digital = NSAttributedString(
            string: "Digital",
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ]
        )

        let full = NSMutableAttributedString()
        full.append(carnet)
        full.append(digital)

        titleLabel.attributedText = full
    }

    private func setupGradient() {
        let leftColor = UIColor(
            red: 0.89,
            green: 0.36,
            blue: 0.93,
            alpha: 1
        ).cgColor

        let rightColor = UIColor(
            red: 0.55,
            green: 0.35,
            blue: 0.94,
            alpha: 1
        ).cgColor

        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = containerView.layer.cornerRadius

        if gradientLayer.superlayer == nil {
            containerView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }

    @IBAction private func ingresarTapped(_ sender: UIButton) {
        print("clase implementada para la interfaz vizual no funciona :/")
    }
}
