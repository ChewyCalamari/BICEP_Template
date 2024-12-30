targetScope = 'resourceGroup'

@description('The Azure region into which the resources should be deployed.')
param location string = resourceGroup().location

@description('Is this a development environment?')
param developmentEnvironment bool = true

@description('The type of environment. This must be nonprod or prod.')
@allowed([
  'nonprod'
  'prod'
])
param environmentType string

@description('This module references an existing network')
module existingNetworking 'modules\existingnetworking_module.bicep' = {
  name: 'existingNetworking'
  params: {
    VirtualNetworkRSG: VirtualNetworkRSG
    VirtualNetwork: VirtualNetworkExisting
    virtualNetworkSubnetServer: virtualNetworkSubnet
    virtualNetworkSubnetPE: virtualNetworkSubnetPE
  }
}

@description('Existing Virtual networking settings')
param VirtualNetworkRSG string = developmentEnvironment ? 'rg-devtest-001' : 'rg-prod-001'
param VirtualNetworkExisting string = developmentEnvironment ? 'vnet-devtest-001' : 'vnet-prod-001'
param virtualNetworkSubnet string = 'server-subnet'
param virtualNetworkSubnetPE string = 'pe-subnet'
