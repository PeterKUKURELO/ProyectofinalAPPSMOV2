import Foundation

final class AuthService {

    func login(request: LoginRequest, completion: @escaping (Result<LoginResponse, AuthError>) -> Void) {

        // Simula llamada a servidor (1s)
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {

            // Credenciales demo
            let okEmail = "test@uc.com"
            let okPassword = "123456"

            if request.email.lowercased() == okEmail && request.password == okPassword {
                completion(.success(LoginResponse(userId: "1", token: "demo_token_abc")))
            } else {
                completion(.failure(.invalidCredentials))
            }
        }
    }
}
