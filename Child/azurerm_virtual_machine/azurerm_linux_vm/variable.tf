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
