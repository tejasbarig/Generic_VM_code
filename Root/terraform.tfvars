rgs = {

  rg1 = {
    rg_name    = "rg1-frc-tej"
    location   = "francecentral"
    managed_by = "Terraform"
    tags = {
      env = "dev"
    }

  }
}
##############################
vnets = {
  vnet1 = {
    vnet_name           = "vnet1-frc-tej"
    location            = "francecentral"
    resource_group_name = "rg1-frc-tej"
    address_space       = ["10.0.0.0/23"] # 512 addresses
    subnets = {
      subnet1 = {
        subnet_name             = "subnet1-frc-tej"
        subnet_address_prefixes = ["10.0.0.0/24"] # 256 addresses
      }
      subnet2 = {
        subnet_name             = "subnet2-frc-tej"
        subnet_address_prefixes = ["10.0.1.0/25"] # 128 addresses
      }
      subnetAZB = {
        subnet_name             = "AzureBastionSubnet"
        subnet_address_prefixes = ["10.0.1.128/26"] # 10.0.0.128/26-24 - 64 to 256 addresses   
      }
      subnet3 = {
        subnet_name             = "subnet3-frc-tej"
        subnet_address_prefixes = ["10.0.1.192/27"] # 32 addresses
      }
    }
  }
}
##############################
nics = {
  nic1 = {
    nic_name    = "nic1-frc-tej"
    rg_name     = "rg1-frc-tej"
    location    = "francecentral"
    vnet_name   = "vnet1-frc-tej"
    subnet_name = "subnet1-frc-tej"

    ip_configurations = {
      ipconfig1 = {
        ip_config_name        = "nic1_internal-frc-tej"
        private_ip_allocation = "Dynamic"
        # private_ip_address    = optional(string)
        # primary               = optional(bool)
        public_ip_name = null # "bastionpip"
      }
    }
  }
  nic2 = {
    nic_name    = "nic2-frc-tej"
    rg_name     = "rg1-frc-tej"
    location    = "francecentral"
    vnet_name   = "vnet1-frc-tej"
    subnet_name = "subnet2-frc-tej"

    ip_configurations = {
      ipconfig2 = {
        ip_config_name        = "nic2_internal1-frc-tej"
        private_ip_allocation = "Dynamic"
        # private_ip_address    = optional(string)
        primary = true
        #public_ip_name        = null  
      }
      ipconfig3 = {
        ip_config_name        = "nic2_internal2-frc-tej"
        private_ip_allocation = "Static"
        private_ip_address    = "10.0.1.75"
        #primary = true
        public_ip_name = null
      }
    }
  }
}
##############################

pips = {
  bastionpip = {
    pip_name = "bastion-pip"
    location = "francecentral"
    rg_name  = "rg1-frc-tej"
  }

  loadbalancer = {
    pip_name = "loadbalancer-pip"
    location = "francecentral"
    rg_name  = "rg1-frc-tej"
  }

}

##############################
linux_vms = {
  frontend = {
    linux_vm_name                = "vm-frt1-frc-tej"
    rg_name                      = "rg1-frc-tej"
    location                     = "francecentral"
    size                         = "Standard_D2s_v3"
    admin_username               = "tejasadmin"
    admin_password               = "Welcometejas1@"
    nic_name                     = "nic1-frc-tej"
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"
    vm_publisher                 = "Canonical"
    vm_offer                     = "0001-com-ubuntu-server-focal"
    vm_sku                       = "20_04-lts"
    vm_version                   = "latest"
    custom_data                  = <<-EOT
      #!/bin/bash
      sudo apt update
      sudo apt upgrade -y
      sudo apt install -y nginx
      sudo rm -rf /var/www/html/*
      git clone https://github.com/devopsinsiders/StreamFlix.git /var/www/html/
      systemctl enable nginx
      systemctl start nginx
    EOT
  }
  backend = {
    linux_vm_name                = "vm-bck1-frc-tej"
    rg_name                      = "rg1-frc-tej"
    location                     = "francecentral"
    size                         = "Standard_F2"
    admin_username               = "tejasadmin"
    admin_password               = "Welcometejas1@"
    nic_name                     = "nic2-frc-tej"
    os_disk_caching              = "ReadWrite"
    os_disk_storage_account_type = "Standard_LRS"
    vm_publisher                 = "Canonical"
    vm_offer                     = "0001-com-ubuntu-server-focal"
    vm_sku                       = "20_04-lts"
    vm_version                   = "latest"
    custom_data                  = <<-EOT
      #!/bin/bash
      apt update -y
      apt upgrade -y
      apt install nginx -y
      rm -rf  /var/www/html/*
      git clone https://github.com/devopsinsiders/starbucks-clone.git /var/www/html/
      systemctl enable nginx
      systemctl start nginx
    EOT
  }
}


##############################
##############################
