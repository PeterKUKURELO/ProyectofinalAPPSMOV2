import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView! {
        didSet { 
            guard tableView != nil else {
                assertionFailure("tableView IBOutlet not connected")
                return
            }
            setupTableView()
        }
    }
    
    // MARK: - Properties
    private var viewModel: HomeViewModel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        loadData()
    }
    
    // MARK: - Setup
    private func setupViewModel() {
        viewModel = HomeViewModel()
        viewModel.delegate = self
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        
        // Registro seguro de celdas
        registerCells(in: tableView, cellTypes: [
            BannerCell.self,
            // Agregar otras celdas aquí
        ])
    }
    
    private func loadData() {
        showLoading()
        viewModel.loadHomeData()
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    func homeViewModelDidLoadData(_ viewModel: HomeViewModel) {
        hideLoading()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func homeViewModel(_ viewModel: HomeViewModel, didFailWithError error: Error) {
        hideLoading()
        showError(error)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = viewModel.cellType(for: indexPath)
        
        switch cellType {
        case .banner:
            let cell: BannerCell = dequeueCell(from: tableView, for: indexPath)
            let model = BannerCell.Model(
                title: "Carnet Digital",
                subtitle: "Tu acceso rápido al campus",
                buttonTitle: "INGRESAR",
                image: UIImage(named: "BannerStudent"),
                onButtonTap: { [weak self] in
                    self?.handleBannerTap()
                }
            )
            cell.configure(with: model)
            return cell
            
        // Agregar otros casos aquí
        }
    }
    
    private func handleBannerTap() {
        // Implementar navegación al carnet
        print("Navigate to Carnet")
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

// MARK: - HomeViewModel
protocol HomeViewModelDelegate: AnyObject {
    func homeViewModelDidLoadData(_ viewModel: HomeViewModel)
    func homeViewModel(_ viewModel: HomeViewModel, didFailWithError error: Error)
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    enum CellType {
        case banner
        // Agregar otros tipos
    }
    
    private var sections: [[CellType]] = []
    
    func loadHomeData() {
        // Simular carga de datos
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            self.sections = [[.banner]]
            self.delegate?.homeViewModelDidLoadData(self)
        }
    }
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard section < sections.count else { return 0 }
        return sections[section].count
    }
    
    func cellType(for indexPath: IndexPath) -> CellType {
        return sections[indexPath.section][indexPath.row]
    }
}