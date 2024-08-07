run "test-vnet" {
  module {
    # the source path is relative to where the `terraform test` command is run
    source = "./modules/vnet"
  }
  variables {
    # variables to pass to the module
    name       = "unit_test"
    cidr_block = "10.0.0.0/16"
  }

  assert {
    condition     = strcontains(azurerm_virtual_network.main.name, "unit_test") == true
    error_message = "Vnet name did not include unit_test in string."
  }

  assert {
    condition     = azurerm_virtual_network.main.resource_group_name == azurerm_resource_group.main.name
    error_message = "Vnet is not in correct resource group."
  }
}

run "test-webapp" {
  module { source = "./modules/static-website" }
  variables {
    files     = ["./website/index.html"]
    name      = "unittest"
    unit_test = true
  }
  assert {
    condition     = strcontains(data.http.get-status["enabled"].status_code, "200")
    error_message = "Static website did not return a 200 code"
  }
}