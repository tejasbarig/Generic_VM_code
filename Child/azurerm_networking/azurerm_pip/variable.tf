variable "pips" {
  type = map(object({
    pip_name = string
    rg_name  = string
    location = string

  }))

}
