# Claude Azure iOS App

## Overview
The Claude Azure iOS App is designed to provide users with the ability to run Claude code sessions in an Azure Container App environment. This application allows users to log in with their cloud code accounts and access their sessions from their mobile devices.

## Project Structure
The project is organized into several directories, each serving a specific purpose:

- **ios/**: Contains the iOS application code, including models, views, view models, services, and configuration files.
- **backend/**: Contains the backend service code, including the server setup, routes, controllers, and services for handling authentication and session management.
- **infra/**: Contains infrastructure as code files for deploying resources to Azure using Bicep templates.
- **config/**: Contains configuration files for OpenID Connect and Azure Container Apps.
- **scripts/**: Contains scripts for automating deployment and secret creation.
- **.github/**: Contains GitHub Actions workflows for CI/CD.

## Getting Started

### Prerequisites
- Xcode (latest version) for iOS development.
- Node.js and npm for backend development.
- Azure account for deploying the application.

### Installation

1. **Clone the repository:**
   ```
   git clone <repository-url>
   cd claude-azure-ios-app
   ```

2. **Set up the backend:**
   - Navigate to the `backend` directory.
   - Install dependencies:
     ```
     npm install
     ```
   - Configure environment variables by creating a `.env` file based on `.env.example`.

3. **Build and run the backend:**
   ```
   npm run build
   npm start
   ```

4. **Set up the iOS app:**
   - Open `ClaudeContainerApp.xcodeproj` in Xcode.
   - Configure any necessary secrets in `Secrets.sample.plist`.
   - Build and run the app on a simulator or physical device.

### Deployment

- Use the scripts in the `scripts/` directory to deploy the backend service and create necessary secrets.
- Deploy Azure resources using the Bicep templates located in the `infra/azure/` directory.

## Usage
- Launch the iOS app and navigate to the login view.
- Enter your cloud code account credentials to authenticate.
- Access your code sessions and manage them through the app interface.

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for any enhancements or bug fixes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.