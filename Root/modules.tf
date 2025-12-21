module "rg" {
  source = "../Child/azurerm_resource_group"
  rgs    = var.rgs
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../Child/azurerm_networking/azurerm_vnet"
  vnets      = var.vnets
}

module "pip" {
  depends_on = [module.rg]
  source     = "../Child/azurerm_networking/azurerm_pip"
  pips       = var.pips
}

module "nic" {
  depends_on = [module.rg, module.vnet, module.pip]
  source     = "../Child/azurerm_networking/azurerm_nic"
  nics       = var.nics
  pip_ids    = module.pip.pip_ids
}

module "linux_vms" {
  depends_on = [module.rg, module.nic,module.pip]
  source     = "../Child/azurerm_virtual_machine/azurerm_linux_vm"
  linux_vms  = var.linux_vms
}

module "mssql_server" {
  depends_on = [ module.rg ]
  source       = "../Child/azurerm_database/azurerm_database_server"
  mssql_server = var.mssql_server
}

module "mssql_db" {
  depends_on = [ module.mssql_server ]
  source   = "../Child/azurerm_database/azurerm_database_db"
  mssql_db = var.mssql_db
}
module "mssql_firewall_rule" {
  depends_on = [ module.mssql_server,module.mssql_db ]

  source              = "../Child/azurerm_database/azurerm_database_firewall"
  mssql_firewall_rule = var.mssql_firewall_rule
}
