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

