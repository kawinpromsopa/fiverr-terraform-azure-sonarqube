output "virtual_network_id" {
  description = "The id of the newly created virtual network"
  value       = azurerm_virtual_network.default.id
}

output "virtual_network_name" {
  description = "The Name of the newly created virtual network"
  value       = azurerm_virtual_network.default.name
}

output "virtual_network_location" {
  description = "The location of the newly created virtual network"
  value       = azurerm_virtual_network.default.location
}

output "virtual_network_address_space" {
  description = "The address space of the newly created virtual network"
  value       = azurerm_virtual_network.default.address_space
}

output "virtual_network_subnets" {
  description = "The ids of subnets created inside the newl virtual network"
  value       = azurerm_subnet.default.*.id
}
