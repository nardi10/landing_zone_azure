resource "azurerm_virtual_network" "vnet_shared" {
  name                = local.shared_services.vnet.name
  address_space       = [local.shared_services.vnet.address_space]
  location            = azurerm_resource_group.rg-net-shared-prod.location
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
}

resource "azurerm_subnet" "ad" {
  name                 = local.shared_services.vnet.subnets.ad.name
  address_prefixes     = [local.shared_services.vnet.subnets.ad.address_prefix]
  resource_group_name  = azurerm_resource_group.rg-net-shared-prod.name
  virtual_network_name = azurerm_virtual_network.vnet_shared.name
}

resource "azurerm_subnet" "resolver_outbound" {
  name                 = local.shared_services.vnet.subnets.resolver_outbound.name
  address_prefixes     = [local.shared_services.vnet.subnets.resolver_outbound.address_prefix]
  resource_group_name  = azurerm_resource_group.rg-net-shared-prod.name
  virtual_network_name = azurerm_virtual_network.vnet_shared.name

  delegation {
    name = "dns-resolver-outbound"

    service_delegation {
      name    = local.shared_services.vnet.subnets.resolver_outbound.delegation
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_subnet" "resolver_inbound" {
  name                 = local.shared_services.vnet.subnets.resolver_inbound.name
  address_prefixes     = [local.shared_services.vnet.subnets.resolver_inbound.address_prefix]
  resource_group_name  = azurerm_resource_group.rg-net-shared-prod.name
  virtual_network_name = azurerm_virtual_network.vnet_shared.name

  delegation {
    name = "dns-resolver-inbound"

    service_delegation {
      name    = local.shared_services.vnet.subnets.resolver_inbound.delegation
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}
