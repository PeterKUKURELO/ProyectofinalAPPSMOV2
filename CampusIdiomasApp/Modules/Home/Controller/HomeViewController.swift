import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Demo Data
    private let courses: [CourseItem] = [
        .init(title: "Desarrollo de\nAplicaciones Moviles II", status: "Cursando", imageName: "default_cu_1"),
        .init(title: "Pruebas de software", status: "Cursando", imageName: "default_cu_2"),
        .init(title: "Inglés Intermedio", status: "Cursando", imageName: "default_cu_0")
    ]

    private let todayClasses: [TodayClassItem] = [
        .init(title: "Desarrollo de Aplicaciones Moviles II",
              time: "09:00 - 11:00",
              location: "Campus San Carlos",
              roomOrMode: "B204",
              isHighlighted: false),

        .init(title: "Pruebas de software",
              time: "13:00 - 14:15",
              location: "Google Meet",
              roomOrMode: "Virtual",
              isHighlighted: false)
    ]

    private let extraCoursesCount: Int = 3

    
    private func gradientImage(
        colors: [UIColor],
        size: CGSize
    ) -> UIImage {

        let layer = CAGradientLayer()
        layer.frame = CGRect(origin: .zero, size: size)
        layer.colors = colors.map { $0.cgColor }
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0) // horizontal

        let renderer = UIGraphicsImageRenderer(size: size)
        return renderer.image { ctx in
            layer.render(in: ctx.cgContext)
        }
    }

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        configureNavigationBar()
        view.backgroundColor = .systemBackground

        setupTableView()
        registerHeader()
        registerCells()
    }
    
    private func configureNavigationBar() {

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        let gradient = gradientImage(
            colors: [
                UIColor(red: 251/255, green: 213/255, blue: 252/255, alpha: 1), // FBD5FC
                UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)  // F7F7F7
            ],
            size: CGSize(width: UIScreen.main.bounds.width, height: 88)
        )

        appearance.backgroundImage = gradient
        appearance.shadowColor = .clear

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }


    // MARK: - Setup
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear

        // Separación general (opcional)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 24, right: 0)

        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    private func registerHeader() {
        tableView.register(
            UINib(nibName: SectionHeaderView.identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: SectionHeaderView.identifier
        )
    }

    private func registerCells() {
        tableView.register(
            UINib(nibName: BannerCell.identifier, bundle: nil),
            forCellReuseIdentifier: BannerCell.identifier
        )

        tableView.register(
            UINib(nibName: HorizontalCourseCell.identifier, bundle: nil),
            forCellReuseIdentifier: HorizontalCourseCell.identifier
        )

        tableView.register(
            UINib(nibName: ClassTodayCellTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ClassTodayCellTableViewCell.identifier
        )

        tableView.register(
            UINib(nibName: MoreCoursesCell.identifier, bundle: nil),
            forCellReuseIdentifier: MoreCoursesCell.identifier
        )
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // Banner
        case 1: return 1 // Carrusel cursos
        case 2: return todayClasses.count + 1 // Clases + "+ cursos"
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: BannerCell.identifier,
                for: indexPath
            ) as! BannerCell
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HorizontalCourseCell.identifier,
                for: indexPath
            ) as! HorizontalCourseCell

            cell.configure(items: courses)
            return cell

        case 2:
            // Clases
            if indexPath.row < todayClasses.count {
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: ClassTodayCellTableViewCell.identifier,
                    for: indexPath
                ) as! ClassTodayCellTableViewCell

                // Alternado por row (par/impar) tal como pediste
                cell.configure(with: todayClasses[indexPath.row], row: indexPath.row)
                return cell
            }

            // "+ 3 cursos"
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MoreCoursesCell.identifier,
                for: indexPath
            ) as! MoreCoursesCell

            cell.configure(extraCount: extraCoursesCount)
            return cell

        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 190 // Banner
        case 1: return 190 // Carrusel
        case 2:
            // Clases y "+ cursos"
            if indexPath.row < todayClasses.count { return 120 }
            else { return 44 }
        default:
            return 44
        }
    }

    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 1, 2: return 44
        default: return 0.001
        }
    }

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {

        guard section == 1 || section == 2 else { return nil }

        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: SectionHeaderView.identifier
        ) as? SectionHeaderView else { return nil }

        if section == 1 {
            header.configure(title: "Cursos", actionTitle: "Todos los cursos >")
        } else {
            header.configure(title: "Clases de hoy", actionTitle: "Abrir calendario >")
        }
        return header
    }
}
