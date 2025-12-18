# rgs = {

#   rg1 = {
#     rg_name    = "rg-tejas1"
#     location   = "francecentral"
#     managed_by = "Terraform"
#     tags = {
#       env = "dev"
#     }
#   }
# }

# vnets = {
#   vnet1 = {
#     vnet_name           = "vnet-front"
#     location            = "francecentral"
#     resource_group_name = "rg-tejas1"
#     address_space       = ["10.0.0.0/16"]
#     dns_servers         = ["10.0.0.4", "10.0.0.5"]
#     subnets = {
#       subnet1 = {
#         name             = "subnet-front-1"
#         address_prefixes = ["10.0.1.0/24"]
#       }

#       subnet2 = {
#         name             = "subnet-front-2"
#         address_prefixes = ["10.0.2.0/24"]
#       }
#     }
#   }
# }
