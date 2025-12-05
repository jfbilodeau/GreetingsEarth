param appName string = 'greetingsearth'
param appServicePlanName string = 'greetingsearth-asp'
param location string = 'canadaeast'
param skuName string = 'S1' // Standard tier S1
param skuTier string = 'Standard'
param skuCapacity int = 1

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: skuName
    tier: skuTier
    capacity: skuCapacity
  }
  properties: {
    // For a Windows App Service Plan. Set `reserved: true` to create a Linux plan.
    perSiteScaling: false
    // maximumElasticWorkerCount can be set if using Elastic Premium etc.
  }
  tags: {
    environment: 'prod'
    project: 'GreetingsEarth'
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: appName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      alwaysOn: true
      // Add additional siteConfig settings here as needed
    }
  }
  tags: {
    environment: 'prod'
    project: 'GreetingsEarth'
  }
}

output webAppName string = webApp.name
output webAppDefaultHostName string = webApp.properties.defaultHostName
output appServicePlanId string = appServicePlan.id
