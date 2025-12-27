import UIKit

final class CloudsView: UIView {

    @IBOutlet private weak var cloud1ImageView: UIImageView!
    @IBOutlet private weak var cloud2ImageView: UIImageView!
    @IBOutlet private weak var cloud3ImageView: UIImageView!

    private var isAnimating = false

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }

    private func loadFromNib() {
        // Carga el XIB cuyo root es CloudsView
        let nib = UINib(nibName: "CloudsView", bundle: Bundle(for: CloudsView.self))
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? CloudsView else {
            assertionFailure("CloudsView.xib root no es CloudsView")
            return
        }

        // Copiamos el contenido del root cargado a self
        // (self ya existe; solo “adoptamos” sus subviews)
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    // MARK: - Lifecycle

    override func didMoveToWindow() {
        super.didMoveToWindow()
        if window != nil { startIfNeeded() } else { stop() }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if window != nil { startIfNeeded() }
    }

    // MARK: - Public

    func configure(cloud1: UIImage?, cloud2: UIImage?, cloud3: UIImage?) {
        cloud1ImageView.image = cloud1
        cloud2ImageView.image = cloud2
        cloud3ImageView.image = cloud3
        startIfNeeded()
    }

    // MARK: - Animation

    private func startIfNeeded() {
        guard !isAnimating else { return }
        isAnimating = true

        animate(cloud1ImageView, duration: 18, y: 0)
        animate(cloud2ImageView, duration: 22, y: 6)
        animate(cloud3ImageView, duration: 16, y: -4)
    }

    private func stop() {
        isAnimating = false
        [cloud1ImageView, cloud2ImageView, cloud3ImageView].forEach {
            $0?.layer.removeAllAnimations()
            $0?.transform = .identity
        }
    }

    private func animate(_ cloud: UIImageView, duration: TimeInterval, y: CGFloat) {
        layoutIfNeeded()

        cloud.layer.removeAllAnimations()
        cloud.transform = .identity

        let cloudWidth = max(cloud.bounds.width, 120)
        let startX = bounds.width + cloudWidth
        let endX = -(cloudWidth + 20)

        cloud.transform = CGAffineTransform(translationX: startX, y: y)

        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveLinear, .repeat],
            animations: {
                cloud.transform = CGAffineTransform(translationX: endX, y: y)
            }
        )
    }
}
