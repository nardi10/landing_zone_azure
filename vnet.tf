
resource "azurerm_virtual_network" "VNET-US-SPOKE-01" {
  name                = "VNET-US-SPOKE-01"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg-network.name
  address_space       = ["10.1.0.0/24"]

}

resource "azurerm_virtual_network" "VNET-BR-SPOKE-01" {
  name                = "VNET-BR-SPOKE-01"
  location            = "Brazil South"
  resource_group_name = azurerm_resource_group.rg-network.name
  address_space       = ["10.0.0.0/24"]

}