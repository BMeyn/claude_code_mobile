import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var errorMessage: String?

    var body: some View {
        VStack {
            Text("Login")
                .font(.largeTitle)
                .padding()

            TextField("Username", text: $username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: login) {
                Text("Login")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()

            if isLoggedIn {
                Text("Welcome, \(username)!")
                    .padding()
            }
        }
        .padding()
    }

    private func login() {
        // Implement authentication logic using AuthService
        AuthService.login(username: username, password: password) { success, error in
            if success {
                isLoggedIn = true
                errorMessage = nil
            } else {
                isLoggedIn = false
                errorMessage = error?.localizedDescription ?? "Login failed"
            }
        }
    }
}