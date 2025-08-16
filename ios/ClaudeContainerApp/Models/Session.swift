import Foundation

struct Session: Codable {
    let id: String
    let userId: String
    let code: String
    let createdAt: Date
    let updatedAt: Date
    let status: SessionStatus

    enum SessionStatus: String, Codable {
        case active
        case inactive
        case completed
    }
}