output "resource_group" {
  value = azurerm_resource_group.main.*
}

output "vnet" {
  value = azurerm_virtual_network.main.*
}