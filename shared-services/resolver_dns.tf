resource "azurerm_private_dns_resolver" "resolver" {
  name                = local.dns_resolver.name
  location            = local.dns_resolver.location
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
  virtual_network_id  = azurerm_virtual_network.vnet_shared.id
}


# ============================
# Outbound Endpoint
# ============================
resource "azurerm_private_dns_resolver_outbound_endpoint" "outbound" {
  name                    = local.dns_resolver.endpoints.outbound.name
  location                = local.dns_resolver.location
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id
  subnet_id               = azurerm_subnet.resolver_outbound.id
}

# ============================
# Inbound Endpoint
# ============================
resource "azurerm_private_dns_resolver_inbound_endpoint" "inbound" {
  name                    = local.dns_resolver.endpoints.inbound.name
  location                = local.dns_resolver.location
  private_dns_resolver_id = azurerm_private_dns_resolver.resolver.id

  ip_configurations {
    subnet_id = azurerm_subnet.resolver_inbound.id
  }
}

# ============================
# Forwarding Ruleset
# ============================
resource "azurerm_private_dns_resolver_dns_forwarding_ruleset" "nardi" {
  name                = local.dns_resolver.name
  location            = local.dns_resolver.location
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
  private_dns_resolver_outbound_endpoint_ids = [
    azurerm_private_dns_resolver_outbound_endpoint.outbound.id
  ]
}
