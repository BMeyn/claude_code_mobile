param location string = resourceGroup().location
param appName string
param image string
param environment string

resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: appName
  location: location
  properties: {
    environmentId: environment
    configuration: {
      ingress: {
        external: true
        targetPort: 80
        transport: 'http'
      }
    }
    template: {
      containers: [
        {
          name: appName
          image: image
          resources: {
            cpu: 0.5
            memory: '1.0Gi'
          }
        }
      ]
    }
  }
}

output containerAppUrl string = containerApp.properties.configuration.ingress.fqdn