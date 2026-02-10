# ============================
# ZONA PRIVADA nardi.com.br
# ============================

resource "azurerm_private_dns_zone" "zone_webapp" {
  name                = "rivatelink.azurewebsites.net"
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
}

resource "azurerm_private_dns_zone" "zone_blob" {
  name                = "privatelink.blob.net"
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
}

resource "azurerm_private_dns_zone" "zone_database" {
  name                = "privatelink.database.net"
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
}


resource "azurerm_private_dns_zone" "nardi" {
  name                = "nardi.com"
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "nardi_vnet_ad" {
  name                  = "nardi-vnet-ad"
  private_dns_zone_name = azurerm_private_dns_zone.nardi.name
  resource_group_name   = azurerm_resource_group.rg-net-shared-prod.name
  virtual_network_id    = azurerm_virtual_network.vnet_shared.id
}


# ============================
# ZONA PRIVADA privatelink.azurewebsites.net
# ============================









