output "cognitive_services_key" {
  value = azurerm_cognitive_account.cognitive_acc.primary_access_key
  sensitive = true
}

output "cognitive_services_endpoint" {
  value = azurerm_cognitive_account.cognitive_acc.endpoint
}

output "cog_storage_connection_string" {
  description = "The connection string for the storage account"
  value       = azurerm_storage_account.cognitive_fa_storage_acc.primary_connection_string
  sensitive   = true
}
