resource logAnalytics 'Microsoft.LogAnalytics/workspaces@2020-08-01' = {
  name: 'your-log-analytics-workspace-name'
  location: resourceGroup().location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: 30
    features: {
      searchEnabled: true
      alertsEnabled: true
    }
  }
}

output workspaceId string = logAnalytics.id
output primarySharedKey string = listKeys(logAnalytics.id, '2020-08-01').primarySharedKey