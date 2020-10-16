provider "azurerm" {
  version = ">= 2.2.0"
  features {}
}

terraform {
  required_version = ">= 0.12.0"
}

resource "random_id" "default" {
  byte_length = 4
}

resource "azurerm_virtual_machine" "default" {
  count                         = var.virtual_machine_count
  name                          = "${var.virtual_machine_name}-${count.index}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  availability_set_id           = azurerm_availability_set.default.id
  vm_size                       = var.vm_size
  network_interface_ids         = [element(azurerm_network_interface.default.*.id, count.index)]
  delete_os_disk_on_termination = var.delete_os_disk_on_termination

  storage_image_reference {
    id        = var.id
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.virtual_machine_name}-${random_id.default.hex}-os-disk-${count.index}"
    create_option     = "FromImage"
    caching           = "ReadWrite"
  }

  storage_data_disk {
    name              = "${var.virtual_machine_name}-${random_id.default.hex}-data-disk-${count.index}"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = var.data_disk_size_gb
  }

  os_profile {
    computer_name  = "${var.virtual_machine_name}-${count.index}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  tags = var.tags
  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_availability_set" "default" {
  name                         = "${var.virtual_machine_name}-avset-${random_id.default.hex}"
  location                     = var.location
  resource_group_name          = var.resource_group_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 2
  managed                      = true
}

resource "azurerm_public_ip" "default" {
  name                    = "public_ip" 
  location                = var.location
  resource_group_name     = var.resource_group_name
  allocation_method       = "Dynamic"
  idle_timeout_in_minutes = 30
  tags                    = var.tags
}

resource "azurerm_network_interface" "default" {
  count                         = var.virtual_machine_count
  name                          = "${var.virtual_machine_name}-nic-${random_id.default.hex}-${count.index}"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  enable_accelerated_networking = var.enable_accelerated_networking

  ip_configuration {
    name                          = "${var.virtual_machine_name}-ip-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.default.id
  }
  tags = var.tags
}
