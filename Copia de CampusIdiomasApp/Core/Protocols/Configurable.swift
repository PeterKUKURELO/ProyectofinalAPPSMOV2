import UIKit

// MARK: - Configurable Protocol
protocol Configurable {
    associatedtype Model
    func configure(with model: Model)
}

// MARK: - IBOutlet Validation
protocol IBOutletValidatable {
    func validateOutlets()
}

extension IBOutletValidatable where Self: UIView {
    func validateOutlets() {
        let mirror = Mirror(reflecting: self)
        
        for child in mirror.children {
            if let propertyName = child.label,
               propertyName.contains("IBOutlet"),
               child.value is NSNull {
                assertionFailure("IBOutlet '\(propertyName)' is not connected in \(type(of: self))")
            }
        }
    }
}

// MARK: - Safe XIB Loading
extension UIView {
    static func fromNib<T: UIView>() -> T {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: String(describing: T.self), bundle: bundle)
        
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
            fatalError("Could not load view from nib: \(String(describing: T.self))")
        }
        
        return view
    }
}