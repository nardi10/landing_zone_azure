# ============================
# ZONA PRIVADA nardi.com.br
# ============================

resource "azurerm_private_dns_zone" "zone_webapp" {
  name                = local.private_dns_zones.webapp.name
  resource_group_name = azurerm_resource_group.rg-ad.name
}

resource "azurerm_private_dns_zone" "zone_blob" {
  name                = local.private_dns_zones.blob.name
  resource_group_name = azurerm_resource_group.rg-ad.name
}

resource "azurerm_private_dns_zone" "zone_database" {
  name                = local.private_dns_zones.database.name
  resource_group_name = azurerm_resource_group.rg-ad.name
}


resource "azurerm_private_dns_zone" "nardi" {
  name                = local.private_dns_zones.nardi.name
  resource_group_name = azurerm_resource_group.rg-ad.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "nardi_vnet_ad" {
  name                  = "nardi-vnet-ad"
  private_dns_zone_name = azurerm_private_dns_zone.nardi.name
  resource_group_name   = azurerm_resource_group.rg-ad.name
  virtual_network_id    = azurerm_virtual_network.vnet_ad.id
}


# ============================
# ZONA PRIVADA privatelink.azurewebsites.net
# ============================
resource "azurerm_private_dns_zone" "webapp" {
  name                = local.private_dns_zones.webapp.name
  resource_group_name = azurerm_resource_group.rg-ad.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "webapp_vnet_ad" {
  name                  = "webapp-vnet-ad"
  private_dns_zone_name = azurerm_private_dns_zone.webapp.name
  registration_enabled  = true
  resource_group_name   = azurerm_resource_group.rg-ad.name
  virtual_network_id    = azurerm_virtual_network.vnet_ad.id
}

resource "azurerm_private_dns_a_record" "webapp_test6" {
  name                = "teste6"
  records             = ["7.7.7.7"]
  ttl                 = 3600
  resource_group_name = azurerm_resource_group.rg-ad.name
  zone_name           = azurerm_private_dns_zone.webapp.name
}

resource "azurerm_private_dns_a_record" "webapp_spoke01" {
  name                = "webapp-spoke-01"
  records             = ["172.16.0.4"]
  ttl                 = 10
  resource_group_name = azurerm_resource_group.rg-ad.name
  zone_name           = azurerm_private_dns_zone.webapp.name
}

resource "azurerm_private_dns_a_record" "webapp_spoke01_scm" {
  name                = "webapp-spoke-01.scm"
  records             = ["172.16.0.4"]
  ttl                 = 10
  resource_group_name = azurerm_resource_group.rg-ad.name
  zone_name           = azurerm_private_dns_zone.webapp.name
}

# ============================
# ZONA PRIVADA privatelink.blob.core.windows.net
# ============================
resource "azurerm_private_dns_zone" "blob" {
  name                = local.private_dns_zones.blob.name
  resource_group_name = azurerm_resource_group.rg-ad.name
}

# ============================
# ZONA PRIVADA privatelink.database.windows.net
# ============================


