resource "azurerm_resource_group" "main" {
  location = "UK South"
  name     = format("rg-dms1981-%s", terraform.workspace)
  tags     = {
    owner = "david.sibley@digital.justice.gov.uk"
    environment = terraform.workspace
  }
}