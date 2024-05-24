resource "random_id" "name" {
  byte_length = 4
}

resource "azurerm_resource_group" "main" {
  location = "UK South"
  name     = format("%s-%s-%s-rg", random_id.name.hex, var.name, terraform.workspace)
  tags = merge(
    local.tags,
    { Name = format("%s-%s-%s-rg", random_id.name.hex, var.name, terraform.workspace) }
  )
}

resource "azurerm_virtual_network" "main" {
  address_space       = [var.cidr_block]
  location            = azurerm_resource_group.main.location
  name                = format("%s-%s-%s-rg", random_id.name.hex, var.name, terraform.workspace)
  resource_group_name = azurerm_resource_group.main.name
  tags = merge(
    local.tags,
    { Name = format("%s-%s-%s-rg", random_id.name.hex, var.name, terraform.workspace) }
  )
}