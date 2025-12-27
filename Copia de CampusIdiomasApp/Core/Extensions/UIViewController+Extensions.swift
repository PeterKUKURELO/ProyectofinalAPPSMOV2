import UIKit

// MARK: - Safe Cell Registration & Dequeue
extension UIViewController {
    
    /// Registra múltiples celdas de forma segura
    func registerCells<T: UITableViewCell>(in tableView: UITableView, cellTypes: [T.Type]) where T: ReusableView & NibLoadable {
        cellTypes.forEach { cellType in
            tableView.register(cellType)
        }
    }
    
    /// Dequeue seguro con validación de tipo
    func dequeueCell<T: UITableViewCell>(from tableView: UITableView, for indexPath: IndexPath) -> T where T: ReusableView {
        return tableView.dequeueReusableCell(for: indexPath)
    }
}

// MARK: - Alert Helpers
extension UIViewController {
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
    
    func showError(_ error: Error) {
        showAlert(title: "Error", message: error.localizedDescription)
    }
}

// MARK: - Loading State
extension UIViewController {
    
    private struct AssociatedKeys {
        static var loadingView = "loadingView"
    }
    
    private var loadingView: UIView? {
        get { objc_getAssociatedObject(self, &AssociatedKeys.loadingView) as? UIView }
        set { objc_setAssociatedObject(self, &AssociatedKeys.loadingView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func showLoading() {
        guard loadingView == nil else { return }
        
        let loading = UIView()
        loading.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loading.translatesAutoresizingMaskIntoConstraints = false
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        
        loading.addSubview(activityIndicator)
        view.addSubview(loading)
        
        NSLayoutConstraint.activate([
            loading.topAnchor.constraint(equalTo: view.topAnchor),
            loading.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loading.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loading.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: loading.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loading.centerYAnchor)
        ])
        
        loadingView = loading
    }
    
    func hideLoading() {
        loadingView?.removeFromSuperview()
        loadingView = nil
    }
}