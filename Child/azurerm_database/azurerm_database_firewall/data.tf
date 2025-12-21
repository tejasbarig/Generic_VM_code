data "azurerm_mssql_server" "mssql" {
  for_each            = var.mssql_firewall_rule
  name                = each.value.mssql_server_name
  resource_group_name = each.value.rg_name
}
