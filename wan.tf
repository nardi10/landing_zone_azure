resource "azurerm_virtual_wan" "virtual_wan" {
  name                = "VWAN-NARDI"
  resource_group_name = azurerm_resource_group.rg-network.name
  location            = azurerm_resource_group.rg-network.location
}

resource "azurerm_virtual_hub" "br-hub" {
  name                = "br-hub"
  resource_group_name = azurerm_resource_group.rg-network.name
  location            = "Brazil South"
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan.id
  address_prefix      = "10.10.0.0/24"
}

resource "azurerm_virtual_hub" "us-hub" {
  name                = "us-hub"
  resource_group_name = azurerm_resource_group.rg-network.name
  location            = "East US"
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan.id
  address_prefix      = "10.11.0.0/24"
}