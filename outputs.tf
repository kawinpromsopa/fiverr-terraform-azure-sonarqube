output "resource_group_name" {
  description = "The name of the resource group"
  value       = module.resource_group
}

output "virtual_network_id" {
  description = "The name of the resource group"
  value       = module.virtual_network.virtual_network_id
}

output "virtual_network_name" {
  description = "The Name of the newly created virtual network"
  value       = module.virtual_network.virtual_network_name
}

output "virtual_network_location" {
  description = "The location of the newly created virtual network"
  value       = module.virtual_network.virtual_network_location
}

output "virtual_network_address_space" {
  description = "The address space of the newly created virtual network"
  value       = module.virtual_network.virtual_network_address_space
}

output "virtual_network_subnets" {
  description = "The ids of subnets created inside the newl virtual network"
  value       = module.virtual_network.virtual_network_subnets
}

output "virtual_machine_dmz_ids" {
  description = "Virtual machine ids created."
  value       = module.virtual_machine.virtual_machine_ids
}

output "network_interface_dmz_ids" {
  description = "ids of the vm nics provisoned."
  value       = module.virtual_machine.network_interface_ids
}

output "network_interface_dmz_private_ip" {
  description = "private ip addresses of the vm nics"
  value       = module.virtual_machine.network_interface_private_ip
}

output "availability_set_dmz_id" {
  description = "id of the availability set where the vms are provisioned."
  value       = module.virtual_machine.availability_set_id
}
