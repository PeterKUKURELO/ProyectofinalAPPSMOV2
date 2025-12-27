import UIKit

final class CarnetViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = CarnetViewModel()

    private enum Section: Int, CaseIterable {
        case header
        case info
        case clock
        case offlineBanner
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        registerCells()
        bind()
        viewModel.onViewDidLoad()
    }

    private func registerCells() {
        tableView.register(
            UINib(nibName: "CarnetHeaderCell", bundle: nil),
            forCellReuseIdentifier: "CarnetHeaderCell"
        )

        tableView.register(
            UINib(nibName: "CarnetInfoCell", bundle: nil),
            forCellReuseIdentifier: "CarnetInfoCell"
        )

        tableView.register(
            UINib(nibName: "CarnetClockCell", bundle: nil),
            forCellReuseIdentifier: "CarnetClockCell"
        )

        tableView.register(
            UINib(nibName: "CarnetOfflineBannerCell", bundle: nil),
            forCellReuseIdentifier: "CarnetOfflineBannerCell"
        )
    }

    private func setupTable() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension

        // Si usas celdas prototipo en storyboard, NO necesitas register().
        // Si usas XIB, aquí registrarías.
    }

    private func bind() {
        viewModel.onStateChange = { [weak self] _ in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
}

extension CarnetViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let section = Section(rawValue: indexPath.section) else {
            return UITableViewCell()
        }

        let state = viewModel.state

        switch section {

        case .header:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: "CarnetHeaderCell",
                for: indexPath
            ) as! CarnetHeaderCell

            cell.configure(
                avatar: state.avatarImage,
                foreground: state.foregroundImage,
                clouds: state.cloudsImage
            )

            return cell


        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarnetInfoCell", for: indexPath) as! CarnetInfoCell
            cell.configure(
                fullName: state.fullName,
                career: state.career,
                campus: state.campus,
                code: state.code,
                email: state.email
            )
            return cell

        case .clock:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarnetClockCell", for: indexPath) as! CarnetClockCell
            cell.configure(
                dateText: state.formattedDate,
                timeText: state.formattedTime
            )

            return cell

        case .offlineBanner:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CarnetOfflineBannerCell", for: indexPath) as! CarnetOfflineBannerCell
            cell.configure(message: state.offlineMessage, isVisible: state.isOffline)
            return cell
        }
    }

}

extension CarnetViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 0.01 }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { 0.01 }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { return UITableView.automaticDimension }

        if section == .offlineBanner, viewModel.state.isOffline == false {
            return 0
        }
        return UITableView.automaticDimension
    }
}
