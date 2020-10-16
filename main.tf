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
