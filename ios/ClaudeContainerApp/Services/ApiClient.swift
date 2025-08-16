import Foundation

class ApiClient {
    private let baseURL: URL
    private let session: URLSession

    init(baseURL: URL) {
        self.baseURL = baseURL
        self.session = URLSession.shared
    }

    func login(username: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/login")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["username": username, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "ApiClientError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            if let token = String(data: data, encoding: .utf8) {
                completion(.success(token))
            } else {
                completion(.failure(NSError(domain: "ApiClientError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response data"])))
            }
        }

        task.resume()
    }

    func fetchSessions(completion: @escaping (Result<[Session], Error>) -> Void) {
        let url = baseURL.appendingPathComponent("/sessions")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "ApiClientError", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }

            do {
                let sessions = try JSONDecoder().decode([Session].self, from: data)
                completion(.success(sessions))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}