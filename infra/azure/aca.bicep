param appName string = 'claude-container-app'
param environment string = 'production'
param location string = resourceGroup().location
param image string = 'youracr.azurecr.io/your-image:latest'

resource containerApp 'Microsoft.App/containerApps@2022-03-01' = {
  name: appName
  location: location
  properties: {
    kubeEnvironmentId: '/subscriptions/{subscription-id}/resourceGroups/{resource-group-name}/providers/Microsoft.App/kubeEnvironments/{kube-environment-name}'
    configuration: {
      ingress: {
        external: true
        targetPort: 80
        traffic: [
          {
            revisionName: 'latest'
            weight: 100
          }
        ]
      }
    }
    template: {
      containers: [
        {
          name: appName
          image: image
          resources: {
            cpu: '0.5'
            memory: '1.0Gi'
          }
        }
      ]
    }
  }
}

output containerAppUrl string = containerApp.properties.configuration.ingress.fqdn