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
  shared_services = {
    vnet = {
      name          = "vnet-br-shared-${local.environment}-01"
      location      = local.locations.br
      address_space = "10.0.0.0/16"

      subnets = {
        ad = {
          name           = "snet-ad-01"
          address_prefix = "10.0.0.0/24"
        }

        resolver_outbound = {
          name           = "snet-dns-outbound"
          address_prefix = "10.0.1.0/28"
          delegation     = "Microsoft.Network/dnsResolvers"
        }

        resolver_inbound = {
          name           = "snet-dns-inbound"
          address_prefix = "10.0.1.16/28"
          delegation     = "Microsoft.Network/dnsResolvers"
        }
      }
    }
  }
}


locals {
  dns_resolver = {
    name     = "dnsr-br-${local.environment}-01"
    location = local.locations.br

    endpoints = {
      outbound = {
        name = "dnsr-outbound-01"
      }

      inbound = {
        name = "dnsr-inbound-01"
      }
    }

    rulesets = {
      default = {
        name = "dnsr-ruleset-default"
      }
    }
  }
}
