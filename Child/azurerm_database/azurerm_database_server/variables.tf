variable "mssql_server" {
  type = map(object({
    mssql_server_name            = string
    rg_name                      = string
    location                     = string
    version                      = string
    mssql_administrator_login          = string
    mssql_administrator_login_password = string
    }
  ))

}
