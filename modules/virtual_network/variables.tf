variable "virtual_network_name" {
  description = "Name of the virtual network to create"
  default     = "terraformed"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
  default = "terraformed"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

## If no values specified, this defaults to Azure DNS
variable "dns_servers" {
  description = "The DNS servers to be used with virtual network."
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the virtual network."
  default     = ["subnet_a", "subnet_b", "subnet_c"]
}

variable "network_security_group_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)
  default = {}
}

variable "route_tables_ids" {
  description = "A map of subnet name to Route table ids"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
  default = {
    terraform = "true"
  }
}
