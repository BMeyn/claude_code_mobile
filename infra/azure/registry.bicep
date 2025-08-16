param registryName string
param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2021-06-01' = {
  name: registryName
  location: location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output registryLoginServer string = acr.properties.loginServer
output registryAdminUsername string = acr.properties.adminUserEnabled ? acr.name : ''
output registryAdminPassword string = listKeys(acr).keys[0].value