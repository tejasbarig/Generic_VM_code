variable "mssql_firewall_rule" {
  type = map(object({
    mssql_firewall_rule_name = string
    rg_name                  = string
    server_id                = string
    mssql_server_name        = string
    start_ip_address         = string
    end_ip_address           = string

    }
  ))

}
