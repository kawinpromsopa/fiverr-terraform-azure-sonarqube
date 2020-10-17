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

## Password must be between 6-72 characters long and must satisfy at least 3
admin_password = "JUFDtKqHn8G2Nkgm4f"

security_group_name = "network-sg"
