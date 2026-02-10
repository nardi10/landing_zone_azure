locals {
  environment = "prod"

  locations = {
    br = "Brazil South"
    us = "East US"
  }

  region_codes = {
    "Brazil South" = "br"
    "East US"      = "us"
  }

  default_tags = {
    environment = local.environment
    managedby  = "terraform"
    owner      = "network"
  }
}


locals {
  network_core = {
    virtual_wan = {
      name = "vwan-global-net-${local.environment}-01"

      hubs = {
        br = {
          name           = "vhub-br-net-${local.environment}-01"
          address_prefix = "10.10.0.0/24"
          location       = local.locations.br
        }

        us = {
          name           = "vhub-us-net-${local.environment}-01"
          address_prefix = "10.11.0.0/24"
          location       = local.locations.us
        }
      }
    }
  }
}

