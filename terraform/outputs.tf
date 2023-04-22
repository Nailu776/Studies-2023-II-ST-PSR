output "imgs_storage_connection_string" {
  description = "The connection string for the storage account"
  value       = module.upload.imgs_storage_connection_string
  sensitive = true
}

output "desc_storage_connection_string" {
  description = "The connection string for the storage account"
  value       = module.upload.desc_storage_connection_string
  sensitive = true
}

output "cognitive_services_key" {
  value = module.cognitive.cognitive_services_key
  sensitive = true
}

output "cognitive_services_endpoint" {
  value = module.cognitive.cognitive_services_endpoint
}

output "cog_storage_connection_string" {
  description = "The connection string for the storage account"
  value       = module.cognitive.cog_storage_connection_string
  sensitive   = true
}