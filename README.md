# Terraform and Ansible which creates and configura resources on Azure.

## Prerequisites
- Terraform v0.12.25
- provider.azurerm v2.20.0
- ansible < 2.4
- az cli

These types of resources are supported:

- Azure Services
   - Resource group
   - Virtual network
   - Virtual Machine
   - Netowork Security Group

- Virtual Machine (RHEL 7)
   - Java
   - PostgreSQL
   - SonarQube

## Usage
- 

```
module "resource_group" {
  source                = "./modules/azure/resource_group"

  name     = "Goanywhere-SFTP"
  location = "Uk South"

  tags          = {
    name        = "Goanywhere-SFTP",
    resolver_group = "",
    service        = "",
    primary_application = "",
    secondary_application = "",
    consumer      = "",
    contract      = "",
    business_owner = "",
    application_owner = "",
    environment   = "",
    run_book  = "",
    review_date = "",
    initial_CRQ = "",
    WBS         = "",
    compliance  = ""
  }
}

module "virtual_network" {
  source                 = "./modules/azure/virtual_network"
  resource_group_name    = module.resource_group.resource_group_name

  virtual_network_name   = "TBC"
  address_space          = ["10.0.0.0/16"]
  subnet_prefixes        = ["10.0.1.0/24"]
  subnet_names           = ["private_subnet"]
}

module "container_registry" {
  source                   = "./modules/azure/container_registry"
  resource_group_name      = module.resource_group.resource_group_name

  name                     = "GASFTPACR-1fe4e2al" # must be uniqe name.
  location                 = "Uk South"
  sku                      = "Premium"

  tags          = {
    name        = "GASFTPACR-1fe4e2al",
    resolver_group = "",
    service        = "",
    primary_application = "",
    secondary_application = "",
    consumer      = "",
    contract      = "",
    business_owner = "",
    application_owner = "",
    environment   = "",
    run_book  = "",
    review_date = "",
    initial_CRQ = "",
    WBS         = "",
    compliance  = ""
  }
}


module "container_instances_0" {
  source                = "./modules/azure/container_instances"

  aci = {
      terraform = {
          resource_group_name = module.resource_group.resource_group_name
          name                = "Goanywhere-SFTP01"
          location            = "Uk South"
          ip_address_type     = "public"
          dns_name_label      = "GASFTPACR"
          restart_policy      = "OnFailure"
          os_type             = "Linux"

          tags                = {
             name        = "Goanywhere-SFTP01",
             resolver_group = "",
             service        = "",
             primary_application = "",
             secondary_application = "",
             consumer      = "",
             contract      = "",
             business_owner = "",
             application_owner = "",
             environment   = "",
             run_book  = "",
             review_date = "",
             initial_CRQ = "",
             WBS         = "",
             compliance  = ""
          }

          containers          = {
            goanywhere-sftp01 = {
                image     = "store/helpsystems/goanywhere-mft:6.5.1"
                cpu       = 2
                memory    = 4
                ports     = [
                  {
                      port     = 22
                      protocol = "TCP"
                  },
                  {
                      port     = 443
                      protocol = "TCP"
                  },
                  {
                      port     = 1433
                      protocol = "TCP"
                  },
                  {
                      port     = 8000
                      protocol = "TCP"
                  },
                  {
                      port     = 8001
                      protocol = "TCP"
                  },
          ]
        }
      }
    }
  }
}

module "container_instances_1" {
  source                = "./modules/azure/container_instances"

  aci = {
      terraform = {
          resource_group_name = module.resource_group.resource_group_name
          name                = "Goanywhere-SFTP02"
          location            = "Uk South"
          ip_address_type     = "public"
          dns_name_label      = "GASFTPACR"
          restart_policy      = "OnFailure"
          os_type             = "Linux"

          tags                = {
             name        = "Goanywhere-SFTP02",
             resolver_group = "",
             service        = "",
             primary_application = "",
             secondary_application = "",
             consumer      = "",
             contract      = "",
             business_owner = "",
             application_owner = "",
             environment   = "",
             run_book  = "",
             review_date = "",
             initial_CRQ = "",
             WBS         = "",
             compliance  = ""
          }

          containers          = {
            goanywhere-sftp02 = {
                image     = "store/helpsystems/goanywhere-mft:6.5.1"
                cpu       = 2
                memory    = 4
                ports     = [
                  {
                      port     = 22
                      protocol = "TCP"
                  },
                  {
                      port     = 443
                      protocol = "TCP"
                  },
                  {
                      port     = 1433
                      protocol = "TCP"
                  },
                  {
                      port     = 8000
                      protocol = "TCP"
                  },
                  {
                      port     = 8001
                      protocol = "TCP"
                  },
          ]
        }
      }
    }
  }
}
```


## Authenticate and terraform init, apply
```
az login
terraform init
terraform apply 
```

