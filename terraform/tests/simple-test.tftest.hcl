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
}