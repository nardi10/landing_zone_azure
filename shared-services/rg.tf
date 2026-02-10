resource "azurerm_resource_group" "rg-net-shared-prod" {
  name     = "rg-net-shared-prod"
  location = local.locations.br
}