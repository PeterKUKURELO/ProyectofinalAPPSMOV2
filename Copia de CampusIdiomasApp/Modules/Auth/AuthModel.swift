import Foundation

struct LoginRequest {
    let email: String
    let password: String
}

struct LoginResponse {
    let userId: String
    let token: String
}

enum AuthError: LocalizedError {
    case invalidCredentials
    case network
    case unknown

    var errorDescription: String? {
        switch self {
        case .invalidCredentials: return "Correo o contraseña incorrectos."
        case .network: return "Problema de conexión. Inténtelo nuevamente."
        case .unknown: return "Ocurrió un error inesperado."
        }
    }
}
