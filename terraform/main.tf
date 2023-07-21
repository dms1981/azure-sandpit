resource "azurerm_resource_group" "main" {
  location = "UK South"
  name     = format("rg-dms1981-%s", terraform.workspace)
  tags = merge(
    local.tags,
    { Name = format("rg-dms1981-%s", terraform.workspace) }
  )
}

resource "azurerm_virtual_network" "main" {
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.main.location
  name                = format("vnet-dms1981-%s", terraform.workspace)
  resource_group_name = azurerm_resource_group.main.name
  tags = merge(
    local.tags,
    { Name = format("vnet-dms1981-%s", terraform.workspace) }
  )
}

module "aks_cluster" {
  source = "../terraform-modules/aks-cluster"
  location = azurerm_resource_group.main.location
  name = format("dms1981-%s", terraform.workspace)
  tags = local.tags
}