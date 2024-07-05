output "website_url" {
  value = azurerm_storage_account.main.primary_web_endpoint
}

output "website_status"{
  value = data.http.get-status.status_code
}