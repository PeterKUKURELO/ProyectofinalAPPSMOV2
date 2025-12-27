import UIKit

final class SectionHeaderView: UITableViewHeaderFooterView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var actionButton: UIButton!

    static let identifier = "SectionHeaderView"

    private var action: (() -> Void)?

    func configure(title: String, actionTitle: String, action: (() -> Void)? = nil) {
        titleLabel.text = title
        actionButton.setTitle(actionTitle, for: .normal)

        self.action = action ?? {
            print("clase implementada para la interfaz vizual no funciona :/")
        }
    }

    @IBAction private func actionTapped(_ sender: UIButton) {
        action?()
    }
}

