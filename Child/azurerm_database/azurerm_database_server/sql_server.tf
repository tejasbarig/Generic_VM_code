resource "azurerm_mssql_server" "mssql" {
    for_each = var.mssql_server
  name                         = each.value.mssql_server_name
  resource_group_name          = each.value.rg_name
  location                     = each.value.location
  version                      = each.value.version
  administrator_login          = each.value.mssql_administrator_login 
  administrator_login_password = each.value.mssql_administrator_login_password
}