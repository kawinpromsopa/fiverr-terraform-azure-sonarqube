provider "azurerm" {
  version = ">= 2.2.0"
  features {}
}

terraform {
  required_version = ">= 0.12.0"
}

module "resource_group" {
  source              = "./modules/resource_group"
  name                = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  source                 = "./modules/virtual_network"
  virtual_network_name   = var.virtual_network_name
  resource_group_name    = module.resource_group.resource_group_name
  address_space          = var.address_space
  subnet_prefixes        = var.subnet_prefixes
  subnet_names           = var.subnet_names
}

module "virtual_machine" {
  source              = "./modules/virtual_machine"
  resource_group_name    = module.resource_group.resource_group_name
  virtual_machine_count  = var.virtual_machine_count
  virtual_machine_name   = var.virtual_machine_name 
  location               = var.location 
  subnet_id              = module.virtual_network.virtual_network_subnets[0]
  vm_size                = var.vm_size
  publisher              = var.publisher
  offer                  = var.offer
  sku                    = var.sku
  data_disk_size_gb      = var.data_disk_size_gb
  admin_username         = var.admin_username
  admin_password         = var.admin_password
}

#module "network_security_group" {
#  source              = "./modules/network_security_group"
#  resource_group_name = module.resource_group.resource_group_name
#  security_group_name = var.security_group_name
#  custom_rules = [
#    {
#      name                                  = "sonarqube"
#      priority                              = 201
#      direction                             = "Inbound"
#      access                                = "Allow"
#      protocol                              = "tcp"
#      source_port_range                     = "*"
#      destination_port_range                = "9000"
#      description                           = "sonarqube"
#    },
#  ]
#}

resource "azurerm_network_security_group" "default" {
  name                = "network-sg"
  location            = var.location
  resource_group_name = module.resource_group.resource_group_name
  security_rule {
    name                       = "allow-ssh"
    description                = "allow-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-custom-port"
    description                = "allow-custom-port"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "9000"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "web-windows-vm-nsg-association" {
  subnet_id                 = module.virtual_network.virtual_network_subnets[0]
  network_security_group_id = azurerm_network_security_group.default.id
}
