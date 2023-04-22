output "imgs_storage_connection_string" {
  description = "The connection string for the storage account"
  value       = azurerm_storage_account.imgs_storage_acc.primary_connection_string
  sensitive   = true
}

output "desc_storage_connection_string" {
  description = "The connection string for the storage account"
  value       = azurerm_storage_account.desc_storage_acc.primary_connection_string
  sensitive   = true
}