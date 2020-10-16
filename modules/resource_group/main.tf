provider "azurerm" {
  version = ">= 2.2.0"
  features {}
}

terraform {
  required_version = ">= 0.12.0"
}

resource "azurerm_resource_group" "default" {
  name     = var.name
  location = var.location
  tags     = var.tags
}
