resource "azurerm_network_interface" "nic" {
  for_each            = var.nics
  name                = each.value.nic_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations
    content {
      name      = ip_configuration.value.ip_config_name
      subnet_id = data.azurerm_subnet.subnetdb[each.key].id  #each.key → current NIC key. Terraform assumes NIC key matches subnet key
    
      #private_ip_address_allocation = "Dynamic"   #If IP allocation = Dynamic, You must NOT provide private_ip_address. If IP allocation = Static, You MUST provide private_ip_address
      private_ip_address_allocation = ip_configuration.value.private_ip_allocation
      private_ip_address            = ip_configuration.value.private_ip_allocation == "Static" ? ip_configuration.value.private_ip_address : null
   
   #Attach a Public IP to a NIC only if: A public IP name is provided and That name exists in var.pip_ids. Otherwise → don’t attach anything
   #ip_configuration.value.public_ip_name != null -- >Checks:Did the user specify a public IP at all?
   #contains(keys(var.pip_ids), ip_configuration.value.public_ip_name)-->Checks:Does this public IP name exist in the map of created PIPs?
   public_ip_address_id = try(          #try(condition, false)
        ip_configuration.value.public_ip_name != null && contains(keys(var.pip_ids), ip_configuration.value.public_ip_name), false
      ) ? var.pip_ids[ip_configuration.value.public_ip_name] : null    #null means:Do not send this attribute to Azure”

#primary = try(ip_configuration.value.primary, false) --> What this does: If primary is provided → use it else If missing → default to false
      primary = try(ip_configuration.value.primary, false)

    }
  }


}
