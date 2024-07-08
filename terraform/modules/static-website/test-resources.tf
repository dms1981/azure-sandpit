resource "time_sleep" "main" {
  for_each        = var.unit_test ? { "enabled" = "true" } : {}
  depends_on      = [azurerm_storage_account.main]
  create_duration = "20s"
}

data "http" "get-status" {
  for_each   = var.unit_test ? { "enabled" = "true" } : {}
  depends_on = [time_sleep.main]
  url        = azurerm_storage_account.main.primary_web_endpoint
}

output "status-code" {
  value = var.unit_test ? data.http.get-status["enabled"].status_code : "Not queried"
}