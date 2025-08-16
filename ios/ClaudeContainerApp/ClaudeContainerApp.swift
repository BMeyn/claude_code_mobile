import SwiftUI

@main
struct ClaudeContainerApp: App {
    @StateObject private var sessionViewModel = SessionViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sessionViewModel)
        }
    }
}