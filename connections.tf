 
resource "azurerm_virtual_hub_connection" "conn_br" {
  name                      = "conn_br"
  virtual_hub_id            = azurerm_virtual_hub.br-hub.id
  remote_virtual_network_id = azurerm_virtual_network.VNET-BR-SPOKE-01.id
}

resource "azurerm_virtual_hub_connection" "conn_us" {
  name                      = "conn_us"
  virtual_hub_id            = azurerm_virtual_hub.us-hub.id
  remote_virtual_network_id = azurerm_virtual_network.VNET-US-SPOKE-01.id
}
