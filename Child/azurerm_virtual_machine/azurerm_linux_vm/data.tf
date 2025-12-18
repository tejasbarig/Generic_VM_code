data "azurerm_network_interface" "nic_ids_d" {
  for_each = var.linux_vms
  name                = each.value.nic_name
  resource_group_name = each.value.rg_name
} 