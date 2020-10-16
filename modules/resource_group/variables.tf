variable "location" {
  type = string
  description = "The location to deploy the resource group in to."
  default = "UK South"
}

variable "name" {
  type = string
  description = "The name of the resource group."
  default = "terraformed"
}

variable "tags" {
  type = map(string)
  description = "The tags to associate with your network and subnets."
  default = {
    terraform = "true"
  }
}
