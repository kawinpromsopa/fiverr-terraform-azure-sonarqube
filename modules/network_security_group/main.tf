provider "azurerm" {
  version = ">= 2.2.0"
  features {}
}

terraform {
  required_version = ">= 0.12.0"
}

data "azurerm_resource_group" "default" {
  name = var.resource_group_name
}

resource "azurerm_network_security_group" "default" {
  name                = var.security_group_name
  location            = var.location != "" ? var.location : data.azurerm_resource_group.default.location
  resource_group_name = data.azurerm_resource_group.default.name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "default" {
  count                                      = length(var.predefined_rules)
  name                                       = lookup(var.predefined_rules[count.index], "name")
  priority                                   = lookup(var.predefined_rules[count.index], "priority", 4096 - length(var.predefined_rules) + count.index)
  direction                                  = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 0)
  access                                     = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 1)
  protocol                                   = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 2)
  source_port_ranges                         = split(",", replace(lookup(var.predefined_rules[count.index], "source_port_range", "*"), "*", "0-65535"))
  destination_port_range                     = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 4)
  description                                = element(var.rules[lookup(var.predefined_rules[count.index], "name")], 5)
  source_address_prefix                      = length(lookup(var.predefined_rules[count.index], "source_application_security_group_ids", [])) == 0 ? join(",", var.source_address_prefix) : ""
  destination_address_prefix                 = length(lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", [])) == 0 ? join(",", var.destination_address_prefix) : ""
  resource_group_name                        = data.azurerm_resource_group.default.name
  network_security_group_name                = azurerm_network_security_group.default.name
  source_application_security_group_ids      = lookup(var.predefined_rules[count.index], "source_application_security_group_ids", [])
  destination_application_security_group_ids = lookup(var.predefined_rules[count.index], "destination_application_security_group_ids", [])
}
