

resource "azurerm_resource_group" "rg-app-br-prod" {
  name     = "rg-app-br-prod"
  location = local.locations.br
}

