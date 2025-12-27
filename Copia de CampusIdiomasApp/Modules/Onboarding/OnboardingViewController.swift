import UIKit

final class OnboardingViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!

    private let pages: [OnboardingModel] = [
        OnboardingModel(
            imageName: "Onboarding01_icono",
            title: "Tu carné digital siempre contigo",
            description: "Accede a tu credencial desde el celular cuando la necesites. Úsala para ingresar al campus, servicios y actividades, sin llevar el físico."
        ),
        OnboardingModel(
            imageName: "Onboarding02_icono",
            title: "Todo tu campus en un solo lugar",
            description: "Consulta horarios, cursos, notas y trámites desde la app. Encuentra lo que necesitas con accesos rápidos y sin perder tiempo."
        ),
        OnboardingModel(
            imageName: "Onboarding03_icono",
            title: "No te pierdas nada importante",
            description: "Recibe avisos sobre cambios de clase, eventos, pagos y comunicados oficiales. Activa las notificaciones para estar siempre al día."
        )
    ]

    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            updateButtons()
        }
    }

    private func updateButtons() {
        let isLast = (currentPage == pages.count - 1)
        let arrow = UIImage(named: "rightArrow_1")

        var config = nextButton.configuration ?? UIButton.Configuration.filled()

        // Fondo blanco y forma
        config.background.backgroundColor = .white
        config.baseBackgroundColor = .white
        config.background.cornerRadius = 999

        if isLast {
            // 🔹 ÚLTIMA: solo texto "Empezar" en BOLD y visible
            config.image = nil
            config.title = nil

            // Texto en bold
            var title = AttributedString("Empezar")
            title.font = UIFont.boldSystemFont(ofSize: 17)
            config.attributedTitle = title

            // 🔹 ESTE ES EL COLOR REAL DEL TEXTO (#930296)
            config.baseForegroundColor = UIColor(
                red: 147/255,
                green: 2/255,
                blue: 150/255,
                alpha: 1
            )

            // Padding del botón
            config.contentInsets = NSDirectionalEdgeInsets(
                top: 14,
                leading: 32,
                bottom: 14,
                trailing: 32
            )
        }   else {
            // 🔹 PÁGINAS 1–2: solo flecha
            config.attributedTitle = nil
            config.title = nil
            config.image = arrow
            config.imagePlacement = .all
            config.imagePadding = 0
            config.contentInsets = .init(
                top: 16,
                leading: 16,
                bottom: 16,
                trailing: 16
            )
        }

        nextButton.configuration = config
        skipButton.isHidden = isLast
    }



    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureCollectionView()
        
        collectionView.backgroundColor = .clear
            collectionView.backgroundView = nil
            collectionView.isOpaque = false
    }

    private var lastSize: CGSize = .zero

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard collectionView.bounds.size != lastSize else { return }
        lastSize = collectionView.bounds.size

        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        scrollToPage(index: currentPage, animated: false)
    }


    private func configureUI() {
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false

        skipButton.setTitle("Skip", for: .normal)
        updateButtons()
    }

    private func configureCollectionView() {
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false

        collectionView.dataSource = self
        collectionView.delegate = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.minimumInteritemSpacing = 0
        }
    }

    @IBAction private func didTapSkip(_ sender: UIButton) {
        finishOnboarding()
    }

    @IBAction private func didTapNext(_ sender: UIButton) {
        let isLast = (currentPage == pages.count - 1)
        if isLast {
            finishOnboarding()
        } else {
            scrollToPage(index: currentPage + 1, animated: true)
        }
    }

    private func scrollToPage(index: Int, animated: Bool) {
        guard index >= 0, index < pages.count else { return }

        // Asegura layout estable
        collectionView.layoutIfNeeded()

        currentPage = index

        let pageWidth = collectionView.bounds.width
        let x = CGFloat(index) * pageWidth
        let offset = CGPoint(x: x, y: 0)

        collectionView.setContentOffset(offset, animated: animated)
    }


    private func finishOnboarding() {
        UserDefaults.standard.set(true, forKey: DefaultsKeys.hasSeenOnboarding)
        AppRouter.shared.showMainTab()
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "OnboardingCell",
            for: indexPath
        ) as! OnboardingCell

        cell.configure(with: pages[indexPath.item])
        return cell
    }
}

extension OnboardingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        collectionView.bounds.size
    }
}

extension OnboardingViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = max(1, scrollView.bounds.width)
        let page = Int(round(scrollView.contentOffset.x / pageWidth))
        let clampedPage = max(0, min(page, pages.count - 1))

        if clampedPage != currentPage {
            currentPage = clampedPage
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / max(1, scrollView.bounds.width)))
        currentPage = max(0, min(page, pages.count - 1))
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x / max(1, scrollView.bounds.width)))
        currentPage = max(0, min(page, pages.count - 1))
    }
}
