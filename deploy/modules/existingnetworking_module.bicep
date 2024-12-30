targetScope = 'resourceGroup'

//Params
param VirtualNetworkRSG string
param VirtualNetwork string
param virtualNetworkSubnetServer string
param virtualNetworkSubnetPE string

//Virtual Network
resource virtualNetworkExisting 'Microsoft.Network/virtualNetworks@2023-06-01' existing = {
  name: VirtualNetwork
  scope: resourceGroup(VirtualNetworkRSG)
}

////Web Farm endpoints need to be available on this vnet - this should be a /27 Subnet
resource virtualNetworkSubnetServerExisting 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' existing ={
  name: virtualNetworkSubnetServer
  parent: virtualNetworkExisting
}

//Service / Private endpoints need to be available on this vnet - this should be a /28 Subnet at a minimum
resource virtualNetworkSubnetExistingPE 'Microsoft.Network/virtualNetworks/subnets@2023-06-01' existing ={
  name: virtualNetworkSubnetPE
  parent: virtualNetworkExisting
}

//Outputs
output virtualNetworkResourceGroup string = VirtualNetworkRSG
output virtualNetwork string = virtualNetworkExisting.id
output serverSubnet string = virtualNetworkSubnetServerExisting.id
output privateEndpointBackupSubnet string = virtualNetworkSubnetExistingPE.id
