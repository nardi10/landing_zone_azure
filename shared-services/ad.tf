resource "azurerm_windows_virtual_machine" "dc" {
  name                = "vm-dc01"
  location            = local.locations.br
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
  size                = "Standard_B2ms"

  admin_username = var.admin_user
  admin_password = var.admin_password

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = "nsg-ad"
   location            = local.locations.br
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name

  security_rule {
    name                       = "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "3389"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }

  security_rule {
    name                       = "WinRM"
    priority                   = 110
    direction                  = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "5985"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"
  }
}

resource "azurerm_public_ip" "pip" {
  name                = "pip-dc01"
  location            = local.locations.br
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-dc01"
  location            = local.locations.br
  resource_group_name = azurerm_resource_group.rg-net-shared-prod.name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id      = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

output "dc_public_ip" {
  value = azurerm_public_ip.pip.ip_address
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-ad"
  resource_group_name  = azurerm_resource_group.rg-net-shared-prod.name
  virtual_network_name = azurerm_virtual_network.vnet_shared.name
  address_prefixes     = ["10.0.2.0/24"]
}