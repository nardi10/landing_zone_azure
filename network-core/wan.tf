resource "azurerm_virtual_wan" "virtual_wan" {
  name                = "vwan-net-global-prod-01"
  resource_group_name = azurerm_resource_group.rg-net-global-prod.name
  location            = azurerm_resource_group.rg-net-global-prod.location
}

resource "azurerm_virtual_hub" "br-hub" {
  name                = "vhub-net-br-prod-01"
  resource_group_name = azurerm_resource_group.rg-net-global-prod.name
  location            = local.locations.br
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan.id
  address_prefix      = "10.10.0.0/24"
}

resource "azurerm_virtual_hub" "us-hub" {
  name                = "vhub-net-us-prod-01"
  resource_group_name = azurerm_resource_group.rg-net-global-prod.name
  location            = local.locations.us
  virtual_wan_id      = azurerm_virtual_wan.virtual_wan.id
  address_prefix      = "10.11.0.0/24"
}