import Foundation
import Combine

class SessionViewModel: ObservableObject {
    @Published var session: Session?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let authService: AuthService
    private let apiClient: ApiClient

    init(authService: AuthService = AuthService(), apiClient: ApiClient = ApiClient()) {
        self.authService = authService
        self.apiClient = apiClient
    }

    func login(username: String, password: String) {
        isLoading = true
        authService.login(username: username, password: password)
            .flatMap { [unowned self] _ in
                self.apiClient.fetchSession()
            }
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] session in
                self?.session = session
            })
            .store(in: &cancellables)
    }

    func logout() {
        authService.logout()
        session = nil
    }
}