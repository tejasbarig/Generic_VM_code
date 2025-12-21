resource "azurerm_mssql_firewall_rule" "db_firewall_rule" {
  for_each         = var.mssql_firewall_rule

  name             = each.value.mssql_firewall_rule_name
  server_id        = data.azurerm_mssql_server.mssql[each.key].id
  start_ip_address = each.value.start_ip_address
  end_ip_address   = each.value.end_ip_address
}
