# rgs = {

#   rg1 = {
#     rg_name    = "rg1-frc-tf-tej"
#     location   = "francecentral"
#     managed_by = "Terraform"
#     tags = {
#       env = "dev"
#     }

#   }
# }
# ##############################
# vnets = {
#   vnet1 = {
#     vnet_name           = "vnet1-frc-tej"
#     location            = "francecentral"
#     resource_group_name = "rg1-frc-tf-tej"
#     address_space       = ["10.0.0.0/23"] # 512 addresses
#     subnets = {
#       subnet1 = {
#         subnet_name             = "subnet1-frc-tej"
#         subnet_address_prefixes = ["10.0.0.0/24"] # 256 addresses
#       }
#       subnet2 = {
#         subnet_name             = "subnet2-frc-tej"
#         subnet_address_prefixes = ["10.0.1.0/25"] # 128 addresses
#       }
#       subnetAZB = {
#         subnet_name             = "AzureBastionSubnet"
#         subnet_address_prefixes = ["10.0.1.128/26"] # 10.0.0.128/26-24 - 64 to 256 addresses   
#       }
#       subnet3 = {
#         subnet_name             = "subnet3-frc-tej"
#         subnet_address_prefixes = ["10.0.1.192/27"] # 32 addresses
#       }
#     }
#   }
# }
# ##############################
