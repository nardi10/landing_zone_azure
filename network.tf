# VNET AD
resource "azurerm_virtual_network" "vnet_ad" {
  name                = local.vnet_ad.name
  address_space       = [local.vnet_ad.address_space]
  location            = azurerm_resource_group.rg-ad.location
  resource_group_name = azurerm_resource_group.rg-ad.name
}

resource "azurerm_subnet" "subnet01" {
  name                 = local.vnet_ad.subnets.subnet01.name
  address_prefixes     = [local.vnet_ad.subnets.subnet01.address_prefix]
  resource_group_name  = azurerm_resource_group.rg-ad.name
  virtual_network_name = azurerm_virtual_network.vnet_ad.name
}


resource "azurerm_subnet" "resolver_outbound" {
  name                 = local.vnet_ad.subnets.resolver_outbound.name
  address_prefixes     = [local.vnet_ad.subnets.resolver_outbound.address_prefix]
  resource_group_name  = azurerm_resource_group.rg-ad.name
  virtual_network_name = azurerm_virtual_network.vnet_ad.name

  delegation {
    name = local.vnet_ad.subnets.resolver_outbound.delegation
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = local.vnet_ad.subnets.resolver_outbound.delegation
    }
  }
}

resource "azurerm_subnet" "resolver_inbound" {
  name                 = local.vnet_ad.subnets.resolver_inbound.name
  address_prefixes     = [local.vnet_ad.subnets.resolver_inbound.address_prefix]
  resource_group_name  = azurerm_resource_group.rg-ad.name
  virtual_network_name = azurerm_virtual_network.vnet_ad.name

  delegation {
    name = local.vnet_ad.subnets.resolver_inbound.delegation
    service_delegation {
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
      name    = local.vnet_ad.subnets.resolver_inbound.delegation
    }
  }
}
