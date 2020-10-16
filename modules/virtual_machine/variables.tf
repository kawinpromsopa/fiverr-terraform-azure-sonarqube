variable "virtual_machine_name" {
  description = "local name of the VM"
  default     = ""
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
  default     = "terraformed"
}

variable "subnet_id" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
}

variable "network_security_group_id" {
  description = "A Network Security Group ID to attach to the network interface"
  default = ""
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed"
  default     = "developer"
}

variable "admin_password" {
  description = "The admin password to be used on the VMSS that will be deployed. The password must meet the complexity requirements of Azure"
  default     = ""
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_DS1_V2"
}

variable "virtual_machine_count" {
  description = "Specify the number of vm instances"
  default     = "1"
}

variable "delete_os_disk_on_termination" {
  description = "Delete datadisk when machine is terminated"
  default     = "false"
}

variable "id" {
  description = "The resource ID of the image that you want to deploy if you are using a custom image.Note, need to provide is_windows_image = true for windows custom images."
  default     = ""
}

variable "publisher" {
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "offer" {
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "sku" {
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "data_disk_size_gb" {
  description = "Storage data disk size size"
  default     = ""
}

variable "tags" {
  type        = map
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
    terraform = "true"
  }
}

variable "enable_accelerated_networking" {
  type        = bool
  description = "(Optional) Enable accelerated networking on Network interface."
  default     = false
}
