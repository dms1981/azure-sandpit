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

resource "azurerm_storage_account" "main" {
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  location                 = azurerm_resource_group.main.location
  name                     = replace(format("%s-%s", random_id.name.hex, var.name), "-","")
  resource_group_name      = azurerm_resource_group.main.name

  static_website {
    index_document = "index.html"
  }

  tags = merge(
    local.tags,
    { Name = format("%s-%s-%s-storage", random_id.name.hex, var.name, terraform.workspace) }
  )
}

resource "azurerm_storage_blob" "main" {
  for_each               = toset(var.files)
  name                   = basename(each.key)
  storage_account_name   = azurerm_storage_account.main.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  content_md5            = filemd5(each.key)
  source                 = each.key
}

resource "time_sleep" "main" {
  depends_on = [azurerm_storage_account.main]
  create_duration = "20s"
}

data "http" "get-status" {
  depends_on = [time_sleep.main]
  url = azurerm_storage_account.main.primary_web_endpoint
}