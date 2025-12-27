import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let items: [SettingsItem] = [
        .init(title: "Cuenta",
              subtitle: "Gestiona tu información personal y el acceso a tu cuenta.",
              iconName: "usertime"),

        .init(title: "Seguridad",
              subtitle: "Protege tu cuenta y tu carné digital con opciones adicionales.",
              iconName: "lock"),

        .init(title: "Carné digital",
              subtitle: "Configura el uso y la visualización de tu carné.",
              iconName: "address-card"),

        .init(title: "Notificaciones",
              subtitle: "Decide qué avisos deseas recibir.",
              iconName: "bell"),

        .init(title: "Preferencias",
              subtitle: "Personaliza la experiencia de la aplicación.",
              iconName: "Ajustes"),

        .init(title: "Ayuda",
              subtitle: "Soporte y respuestas a tus dudas.",
              iconName: "question"),

        .init(title: "Información",
              subtitle: "Detalles legales y versión de la app.",
              iconName: "info")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupTableView()
        registerCells()
    }

    private func setupNavigation() {
        title = "Ajustes"
    }

    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
    }

    private func registerCells() {
        tableView.register(
            UINib(nibName: SettingsProfileCell.identifier, bundle: nil),
            forCellReuseIdentifier: SettingsProfileCell.identifier
        )

        tableView.register(
            UINib(nibName: SettingsItemCell.identifier, bundle: nil),
            forCellReuseIdentifier: SettingsItemCell.identifier
        )

        tableView.register(
            UINib(nibName: SettingsLogoutCell.identifier, bundle: nil),
            forCellReuseIdentifier: SettingsLogoutCell.identifier
        )
    }
}

extension SettingsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int { 3 }

    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1                 // Perfil
        case 1: return items.count       // Opciones
        case 2: return 1                 // Logout
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsProfileCell.identifier,
                for: indexPath
            ) as! SettingsProfileCell
            cell.configure(name: "Juan Pérez")
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsItemCell.identifier,
                for: indexPath
            ) as! SettingsItemCell

            cell.configure(with: items[indexPath.row])
            return cell

        case 2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: SettingsLogoutCell.identifier,
                for: indexPath
            ) as! SettingsLogoutCell
            return cell

        default:
            return UITableViewCell()
        }
    }
}

extension SettingsViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case 0: return 96    // Perfil
        case 1: return 80    // Item
        case 2: return 72    // Logout
        default: return 44
        }
    }
}
