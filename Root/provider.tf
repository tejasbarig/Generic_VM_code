terraform {
 required_providers {
  azurerm = {
   source = "hashicorp/azurerm"
   version = "4.54.0"
   }
  }
  
#   backend "azurerm" {
#    resource_group_name = ""
#    storage_account_name = ""
#    container_name = ""
#    key = ""

}

provider "azurerm" {
features {}
subscription_id = "98473d5b-c639-404e-9bf2-91559fe65ff8"
}