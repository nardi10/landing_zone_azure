locals {
  # ============================
  # Localizações
  # ============================
  locations = {
    br = "Brazil South"
    us = "East US"
  }

  # ============================
  # Virtual WAN e Hubs
  # ============================
  virtual_wan = {
    name = "VWAN-NARDI"

    hubs = {
      br = {
        name           = "br-hub"
        address_prefix = "10.10.0.0/24"
        location       = local.locations.br
      }
      us = {
        name           = "us-hub"
        address_prefix = "10.11.0.0/24"
        location       = local.locations.us
      }
    }
  }

  # ============================
  # VNET AD e Subnets
  # ============================
  vnet_ad = {
    name          = "VNET-AD"
    address_space = "10.0.0.0/16"

    subnets = {
      subnet01 = {
        name           = "SUBNET-01"
        address_prefix = "10.0.0.0/24"
      }
      resolver_outbound = {
        name           = "Subnet-Resolver-Outbound"
        address_prefix = "10.0.1.0/28"
        delegation     = "Microsoft.Network/dnsResolvers"
      }
      resolver_inbound = {
        name           = "Subnet-Resolver-Inbound"
        address_prefix = "10.0.1.16/28"
        delegation     = "Microsoft.Network/dnsResolvers"
      }
    }
  }

  # ============================
  # Private DNS Zones
  # ============================
  private_dns_zones = {
    nardi = {
      name = "nardi.com.br"
    }
    webapp = {
      name = "privatelink.azurewebsites.net"
    }
    blob = {
      name = "privatelink.blob.core.windows.net"
    }
    database = {
      name = "privatelink.database.windows.net"
    }
  }

  # ============================
  # DNS Resolver
  # ============================
  dns_resolver = {
    name     = "resolver-01"
    location = local.locations.us

    endpoints = {
      outbound = {
        name = "resolver-endpoint-outbound"
      }
      inbound = {
        name = "resolver-endpoint-inbound"
      }
    }

    rulesets = {
      nardi = {
        name = "rl-nardi"
      }
    }
  }
}
