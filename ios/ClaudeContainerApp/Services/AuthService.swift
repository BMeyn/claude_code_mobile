import Foundation
import Combine

class AuthService {
    private var cancellables = Set<AnyCancellable>()
    private let apiClient: ApiClient
    private let userDefaults: UserDefaults

    init(apiClient: ApiClient = ApiClient(), userDefaults: UserDefaults = .standard) {
        self.apiClient = apiClient
        self.userDefaults = userDefaults
    }

    func login(username: String, password: String) -> AnyPublisher<Session, Error> {
        let loginRequest = LoginRequest(username: username, password: password)
        
        return apiClient.post(endpoint: "/login", body: loginRequest)
            .map { response in
                // Assuming the response contains a session object
                return Session(token: response.token, user: response.user)
            }
            .handleEvents(receiveOutput: { session in
                self.userDefaults.set(session.token, forKey: "authToken")
            })
            .eraseToAnyPublisher()
    }

    func logout() {
        userDefaults.removeObject(forKey: "authToken")
    }

    func isAuthenticated() -> Bool {
        return userDefaults.string(forKey: "authToken") != nil
    }
}

struct LoginRequest: Codable {
    let username: String
    let password: String
}

struct Session: Codable {
    let token: String
    let user: User
}

struct User: Codable {
    let id: String
    let name: String
    let email: String
}