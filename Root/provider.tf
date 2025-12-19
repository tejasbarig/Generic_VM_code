terraform {
 required_providers {
  azurerm = {
   source = "hashicorp/azurerm"
   version = "4.54.0"
   }
  }
  
backend "azurerm" {
resource_group_name = "tejas-rg"
storage_account_name = "tejassaa"
container_name = "tejascs"
key = "dev.generic_code.tfstate"
}
}

provider "azurerm" {
features {}
subscription_id = "98473d5b-c639-404e-9bf2-91559fe65ff8"
}
