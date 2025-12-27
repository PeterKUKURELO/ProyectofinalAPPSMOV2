import UIKit

struct CarnetState {
    var fullName: String
    var career: String
    var campus: String
    var code: String
    var email: String

    var formattedDate: String
    var formattedTime: String

    var isOffline: Bool
    var offlineMessage: String

    var avatarImage: UIImage?

    // Header assets
    var foregroundImage: UIImage?
    var cloudsImage: UIImage?   // ✅ NUEVO (estático)
}

import UIKit

final class CarnetViewModel {

    var onStateChange: ((CarnetState) -> Void)?
    private(set) var state: CarnetState

    private var timer: Timer?

    init() {
        state = CarnetState(
            fullName: "JUAN CARLOS PÉREZ GÓMEZ",
            career: "COMPUTACIÓN E INFORMATICA",
            campus: "Campus San Carlos",
            code: "E2023743",
            email: "e2023743@cic.edu.pe",
            formattedDate: "",
            formattedTime: "",
            isOffline: true,
            offlineMessage: "El CARNET virtual offline (sin conexion a internet) se guardara por el periodo del dia",
            avatarImage: UIImage(named: "avatar_placeholder"),
            foregroundImage: UIImage(named: "carnet_foreground"),
            cloudsImage: UIImage(named: "clouds_static") // ✅ tu nueva imagen
        )
    }

    func onViewDidLoad() {
        tick()
        startClock()
        onStateChange?(state)
    }

    private func startClock() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.tick()
        }
        if let timer { RunLoop.main.add(timer, forMode: .common) }
    }

    private func tick() {
        let now = Date()

        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale(identifier: "es_PE")
        timeFormatter.dateFormat = "HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "es_PE")
        dateFormatter.dateFormat = "EEEE, dd MMM yyyy"

        state.formattedTime = timeFormatter.string(from: now)
        state.formattedDate = dateFormatter.string(from: now).capitalized

        onStateChange?(state)
    }

    deinit { timer?.invalidate() }
}
