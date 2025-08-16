import Foundation

struct AppConfig {
    static let apiBaseUrl = "https://your-api-url.com"
    static let websocketUrl = "wss://your-websocket-url.com"
    static let timeoutInterval: TimeInterval = 30.0
    
    struct Auth {
        static let clientId = "your-client-id"
        static let clientSecret = "your-client-secret"
        static let redirectUri = "your-redirect-uri"
    }
    
    struct Session {
        static let maxSessionDuration: TimeInterval = 3600 // 1 hour
    }
}