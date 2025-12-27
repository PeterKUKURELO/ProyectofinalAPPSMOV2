import UIKit

enum DT {

    enum Size {
        static let contentWidth: CGFloat = 319

        static let logo = CGSize(width: 319, height: 65)

        static let fieldSize = CGSize(width: 319, height: 49)
        static let fieldCornerRadius: CGFloat = 8
        static let fieldBorderWidth: CGFloat = 1
        static let fieldTextInsetLeft: CGFloat = 14

        static let primaryButtonSize = CGSize(width: 319, height: 49)
        static let primaryButtonCornerRadius: CGFloat = 8

        static let googleButtonSize = CGSize(width: 50, height: 50)
        static let googleButtonCornerRadius: CGFloat = 8
        static let googleLogoSize = CGSize(width: 28, height: 28)
    }

    enum Font {
        enum Weight {
            case bold
            case medium

            var postScriptName: String {
                switch self {
                case .bold: return "RedHatDisplay-Bold"
                case .medium: return "RedHatDisplay-Medium"
                }
            }

            var fallback: UIFont.Weight {
                switch self {
                case .bold: return .bold
                case .medium: return .medium
                }
            }
        }

        static func redHatDisplay(_ size: CGFloat, _ weight: Weight) -> UIFont {
            UIFont(name: weight.postScriptName, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight.fallback)
        }

        static let title = redHatDisplay(19, .bold)        // “Acceder a su cuenta”
        static let field = redHatDisplay(16, .medium)      // Texto dentro del input
        static let button = redHatDisplay(16, .bold)       // Texto botón “Iniciar sesión”
        static let connectWith = redHatDisplay(14, .medium) // “- O CONÉCTESE CON -”
    }

    enum Color {
        // Confirmados por ti
        static let fieldText = UIColor(hex: "#040304")
        static let titleText = UIColor.white
        static let buttonText = UIColor.white

        // Placeholder (si Figma tiene otro exacto, cámbialo aquí)
        static let placeholder = UIColor(hex: "#040304").withAlphaComponent(0.55)

        // Input
        static let fieldFill = UIColor.white
        static let fieldBorder = UIColor.white.withAlphaComponent(0.35)
        static let fieldBorderFocus = UIColor.white.withAlphaComponent(0.75)

        // Botón principal (pon aquí el HEX exacto de Figma)
        static let primaryButtonFill = UIColor(hex: "#D946EF") // TODO: cambia al morado de Figma

        // Google botón
        static let googleFill = UIColor.white
        static let googleBorder = UIColor.white.withAlphaComponent(0.35)

        // Gradiente de fondo (pon aquí los HEX reales)
        static let gradientTop = UIColor(hex: "#A32BC8")       // TODO
        static let gradientBottom = UIColor(hex: "#7A1E8C")    // TODO
    }
}

// MARK: - UIColor hex helper
extension UIColor {
    convenience init(hex: String) {
        var s = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if s.hasPrefix("#") { s.removeFirst() }
        var rgb: UInt64 = 0
        Scanner(string: s).scanHexInt64(&rgb)

        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
