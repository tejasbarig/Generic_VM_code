output "pip_ids" {
  value = {
    for k, pip in azurerm_public_ip.pip : pip.name => pip.id
  }
}
