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
    size                         = "Standard_D2s_v3"
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
mssql_server = {
  "mssql_server_1" = {
    mssql_server_name            = "frontend-vm-sql"
    rg_name                      = "rg1-frc-tej"
    location                     = "francecentral"
    version                      = "12.0"
    mssql_administrator_login          = "tejasadmin"
    mssql_administrator_login_password = "Welcometejas1@"

  }
}

############################## 
mssql_db = {
  db1 = {
    mssql_db_name     = "app_tej_db"
    mssql_server_name = "frontend-vm-sql"
    rg_name           = "rg1-frc-tej"
    sku_name          = "S0"
  }
  db2 = {
    mssql_db_name     = "analytic_tej_sdb"
    mssql_server_name = "frontend-vm-sql"
    rg_name           = "rg1-frc-tej"
    sku_name          = "S1"
    max_size_gb       = 20
    zone_redundant    = false
  }
}

##############################

mssql_firewall_rule = {
  mssql_firewall_rule-AllowIP1 = {
    server_id                = "server1"
    mssql_server_name        = "frontend-vm-sql"
    mssql_firewall_rule_name = "AllowIP1"
    rg_name           = "rg1-frc-tej"
    start_ip_address         = "10.0.17.62"
    end_ip_address           = "10.0.17.62"
  }

  mssql_firewall_rule--AllowIP2 = {
    server_id                = "server1"
    mssql_server_name        = "frontend-vm-sql"
    mssql_firewall_rule_name = "AllowIP2"
    rg_name           = "rg1-frc-tej"
    start_ip_address         = "49.43.131.11"
    end_ip_address           = "49.43.131.11"
  }
}

##############################
