resource "azurerm_resource_group" "rg-network" {
  name     = "rgnetwork"
  location = "Brazil South"
}

resource "azurerm_resource_group" "rg-ad" {
  location = local.locations.us
  name     = "rgad"
}

