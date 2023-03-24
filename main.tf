resource "azurerm_resource_group" "main" {
  location = "UK South"
  name     = format("rg-dms1981-%s", terraform.workspace)
  tags     = {
    owner = "david.sibley@digital.justice.gov.uk"
    environment = terraform.workspace
  }
}

resource "azurerm_virtual_network" "main" {
  address_space       = ["10.0.0.0/16"]
  location            = "UK South"
  name                = format("vnet-dms1981-%s", terraform.workspace)
  resource_group_name = azurerm_resource_group.main.name
  tags     = {
    owner = "david.sibley@digital.justice.gov.uk"
    environment = terraform.workspace
  }
}