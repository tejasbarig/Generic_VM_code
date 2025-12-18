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
