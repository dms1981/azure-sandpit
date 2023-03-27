terraform {
  backend "azurerm" {
    resource_group_name  = "dms1981-tfstate"
    storage_account_name = "dms1981tfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}