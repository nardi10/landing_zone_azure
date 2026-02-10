resource "azurerm_resource_group" "rg-net-global-prod" {
  name     = "rg-net-global-prod"
  location = local.locations.br
}
