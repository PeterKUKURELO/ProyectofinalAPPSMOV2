import UIKit

final class BannerCell: UITableViewCell, NibLoadable, Configurable, IBOutletValidatable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var containerView: UIView! {
        didSet { validateOutlet(containerView, name: "containerView") }
    }
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet { validateOutlet(titleLabel, name: "titleLabel") }
    }
    
    @IBOutlet private weak var subtitleLabel: UILabel! {
        didSet { validateOutlet(subtitleLabel, name: "subtitleLabel") }
    }
    
    @IBOutlet private weak var ingresarButton: UIButton! {
        didSet { validateOutlet(ingresarButton, name: "ingresarButton") }
    }
    
    @IBOutlet private weak var studentImageView: UIImageView! {
        didSet { validateOutlet(studentImageView, name: "studentImageView") }
    }
    
    // MARK: - Properties
    private let gradientLayer = CAGradientLayer()
    
    // MARK: - Model
    struct Model {
        let title: String
        let subtitle: String
        let buttonTitle: String
        let image: UIImage?
        let onButtonTap: (() -> Void)?
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = containerView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.attributedText = nil
        subtitleLabel.text = nil
        studentImageView.image = nil
    }
    
    // MARK: - Configuration
    func configure(with model: Model) {
        configureTitle(model.title)
        subtitleLabel.text = model.subtitle
        ingresarButton.setTitle(model.buttonTitle, for: .normal)
        studentImageView.image = model.image
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.layer.cornerRadius = 24
        containerView.clipsToBounds = true
        
        subtitleLabel.textColor = UIColor.white.withAlphaComponent(0.9)
        
        setupButton()
        setupImageView()
    }
    
    private func setupButton() {
        ingresarButton.setTitleColor(.white, for: .normal)
        ingresarButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        ingresarButton.backgroundColor = UIColor(red: 0.65, green: 0.18, blue: 0.70, alpha: 1)
        ingresarButton.layer.cornerRadius = 11.8
        ingresarButton.clipsToBounds = true
    }
    
    private func setupImageView() {
        studentImageView.contentMode = .scaleAspectFit
    }
    
    private func configureTitle(_ title: String) {
        let components = title.components(separatedBy: " ")
        guard components.count >= 2 else {
            titleLabel.text = title
            return
        }
        
        let carnet = NSAttributedString(
            string: "\(components[0]) ",
            attributes: [
                .foregroundColor: UIColor.black,
                .font: UIFont.systemFont(ofSize: 20, weight: .regular)
            ]
        )
        
        let digital = NSAttributedString(
            string: components[1],
            attributes: [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 20, weight: .bold)
            ]
        )
        
        let attributedText = NSMutableAttributedString()
        attributedText.append(carnet)
        attributedText.append(digital)
        
        titleLabel.attributedText = attributedText
    }
    
    private func setupGradient() {
        let leftColor = UIColor(red: 0.89, green: 0.36, blue: 0.93, alpha: 1).cgColor
        let rightColor = UIColor(red: 0.55, green: 0.35, blue: 0.94, alpha: 1).cgColor
        
        gradientLayer.colors = [leftColor, rightColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.cornerRadius = 24
        
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func validateOutlet<T>(_ outlet: T?, name: String) {
        guard outlet != nil else {
            assertionFailure("IBOutlet '\(name)' is not connected in \(type(of: self))")
            return
        }
    }
    
    // MARK: - Actions
    @IBAction private func ingresarTapped(_ sender: UIButton) {
        // Implementar callback o delegate pattern
        print("Banner button tapped - implement navigation logic")
    }
}