resource "azurerm_network_security_group" "nsg" {
    for_each = var.nsg
  name                = var.value.nsg_name
  location            = var.value.location
  resource_group_name = var.value.resource_group_name

dynamic "security_rule" {
    for_each = var.rules
    content {
    name                       = security_rule.value.rules_name
    priority                   = security_rule.value.priority
    direction                  = security_rule.value.direction
    access                     = security_rule.value.access
    protocol                   = security_rule.value.protocol
    source_port_range          = security_rule.value.source_port_range
    destination_port_range     = security_rule.value.destination_port_range
    source_address_prefix      = security_rule.value.source_address_prefix
    destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }

  