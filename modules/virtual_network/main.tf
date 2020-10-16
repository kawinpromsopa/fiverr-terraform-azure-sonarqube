provider "azurerm" {
  version = ">= 2.2.0"
  features {}
}

terraform {
  required_version = ">= 0.12.0"
}

data azurerm_resource_group "default" {
  name = var.resource_group_name
}

data "azurerm_subnet" "default" {
  for_each             = var.network_security_group_ids
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name

  depends_on = [azurerm_subnet.default]
}

resource "azurerm_virtual_network" "default" {
  name                = var.virtual_network_name
  resource_group_name = data.azurerm_resource_group.default.name
  location            = data.azurerm_resource_group.default.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}

resource "azurerm_subnet" "default" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = data.azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefixes     = [var.subnet_prefixes[count.index]]
}

resource "azurerm_subnet_network_security_group_association" "default" {
  for_each                  = var.network_security_group_ids
  subnet_id                 = data.azurerm_subnet.default[each.key].id
  network_security_group_id = each.value
}

resource "azurerm_subnet_route_table_association" "default" {
  for_each       = var.route_tables_ids
  route_table_id = each.value
  subnet_id      = data.azurerm_subnet.default[each.key].id
}
