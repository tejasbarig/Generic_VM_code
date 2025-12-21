variable "rgs" {
  type = map(object({
    rg_name    = string
    location   = string
    managed_by = optional(string)
    tags       = optional(map(string))
    }
  ))

}

variable "vnets" {
  type = map(object({
    vnet_name           = string
    location            = string
    resource_group_name = string
    address_space       = list(string)

    subnets = optional(map(object({
      subnet_name             = string
      subnet_address_prefixes = list(string)
      }
    )))
  }))

}


variable "nics" {
  type = map(object({
    nic_name    = string
    rg_name     = string
    location    = string
    vnet_name   = string
    subnet_name = string

    ip_configurations = map(object({
      ip_config_name        = string
      private_ip_allocation = string
      private_ip_address    = optional(string)
      primary               = optional(bool)
      public_ip_name        = optional(string)
    }))
  }))
}

# variable "pip_ids" {
#   type = map(string)
# }


variable "pips" {
  type = map(object({
    pip_name = string
    rg_name  = string
    location = string

  }))

}

variable "linux_vms" {
  type = map(object({
    linux_vm_name                = string
    rg_name                      = string
    location                     = string
    size                         = string
    admin_username               = string
    admin_password               = string
    nic_name                     = string
    os_disk_caching              = string
    os_disk_storage_account_type = string
    vm_publisher                 = string
    vm_offer                     = string
    vm_sku                       = string
    vm_version                   = string
    custom_data                  = optional(string)
    }
  ))

}

variable "mssql_server" {
  type = map(object({
    mssql_server_name                  = string
    rg_name                            = string
    location                           = string
    version                            = string
    mssql_administrator_login          = string
    mssql_administrator_login_password = string
    }
  ))

}

variable "mssql_db" {

  type = map(object({
    mssql_db_name     = string
    mssql_server_name = string
    rg_name           = string
    sku_name          = string
    collation         = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    max_size_gb       = optional(number, 5)
    zone_redundant    = optional(bool, false)
  }))
}

variable "mssql_firewall_rule" {
  type = map(object({
    mssql_firewall_rule_name = string
    rg_name                  = string
    server_id                = string
    mssql_server_name        = string
    start_ip_address         = string
    end_ip_address           = string

    }
  ))

}
