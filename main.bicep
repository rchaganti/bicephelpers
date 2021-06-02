param storageAccountName string

resource sa 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  name: '${storageAccountName}'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
  	accessTier: 'Hot'
  }
}

output saId string = resourceId('Microsoft.Storage/storageAccounts', storageAccountName)
