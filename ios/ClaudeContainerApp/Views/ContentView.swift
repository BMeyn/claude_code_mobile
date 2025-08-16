import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            if isLoggedIn {
                // Main app content goes here
                Text("Welcome to Claude Code Sessions!")
            } else {
                LoginView(username: $username, password: $password, isLoggedIn: $isLoggedIn)
            }
        }
        .navigationTitle("Claude Container App")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}