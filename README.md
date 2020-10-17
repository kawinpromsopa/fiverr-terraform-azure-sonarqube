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

- Customize Terraform values into `./workspace/sonarqube-server.tfvars`

```
resource_group_name = "rg-sonarqube"

location = "Southeast Asia"

virtual_network_name = "vnet-sonarqube"

address_space = ["10.0.0.0/16"]

subnet_prefixes = ["10.0.1.0/24"]

subnet_names = ["sonarqube_subnet"]

virtual_machine_count = 1

virtual_machine_name = "vm-sonarqube"

vm_size = "Standard_DS1_v2"

publisher = "RedHat"

offer = "RHEL"

sku = "7.5"

data_disk_size_gb = "15"

admin_username = "centos"

##
## Password must be between 6-72 characters long and must satisfy at least 3
##
admin_password = "JUFDtKqHn8G2Nkgm4f"
```

### Azure authenticate and terraform init, apply

```
az login
terraform init
terraform apply -var-file="./workspace/sonarqube-server.tfvars"
```

- After created an instance then get the Public IP Address of an instance from Azure Interface and put values into `./ansible/inventory/hosts`

```
vm-sonarqube-0 ansible_host=<PUBLIC_IP_ADDRESS>

[sonarqube]
vm-sonarqube-0

[all:vars]
ansible_connection=ssh
ansible_user=centos
ansible_ssh_pass=JUFDtKqHn8G2Nkgm4f
```

### Go to `ansible` directory, And execute ansible playbook to configure Sonaqute service. 
```
export ANSIBLE_CONFIG=.ansible.cfg
ansible-playbook -i inventory/hosts install-sonarqube.yml -b -e "ansible_user=centos ansible_ssh_pass=JUFDtKqHn8G2Nkgm4f ansible_sudo_pass=JUFDtKqHn8G2Nkgm4f"
```

NOTE: `ansible_user`, `ansible_ssh_pass`, `ansible_sudo_pass` values are defined from terraform by values of `admin_username`, and `admin_password`


### After ansible playbook configured access to website as below link:

```
http://<PUBLIC_IP_ADDRESS>:9000/sonarqube
```

