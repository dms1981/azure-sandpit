resource "random_string" "aks-prefix" {
  length  = 12
  special = false
  upper   = false
}

resource "azurerm_resource_group" "main" {
  location = var.location
  name     = format("rg-%s-%s", var.name, terraform.workspace)
  tags = merge(
    var.tags,
    { Name = format("rg-%s-%s", var.name, terraform.workspace) }
  )
}

resource "azurerm_kubernetes_cluster" "main" {
  name                = format("aks-%s", var.name)
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = random_string.aks-prefix.result
  http_application_routing_enabled = true

  default_node_pool {
    name       = format("%s-%s-%s", random_string.aks-prefix.result, var.name, terraform.workspace)
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(
    var.tags,
    { Name = format("rg-%s-%s", var.name, terraform.workspace) }
  )
}
