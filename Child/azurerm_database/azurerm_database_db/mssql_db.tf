resource "azurerm_mssql_database" "db" {
  for_each     = var.mssql_db

  name         = each.value.mssql_db_name
  server_id    = data.azurerm_mssql_server.db[each.key].id
  collation      = lookup(each.value, "collation", "SQL_Latin1_General_CP1_CI_AS")
  sku_name       = each.value.sku_name
  max_size_gb    = lookup(each.value, "max_size_gb", 5)
  zone_redundant = lookup(each.value, "zone_redundant", false)
}
