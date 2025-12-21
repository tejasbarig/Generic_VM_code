variable "mssql_db" {

  type = map(object({
    mssql_db_name     = string
    mssql_server_name = string
    rg_name           = string
    sku_name          = string
    collation         = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    max_size_gb       = optional(number, 5)
    zone_redundant    = optional(bool, false)
  }))
}
