# Storage Acc for frontend
resource "azurerm_storage_account" "front_storage_acc" {
  name                     = var.front_storage_account_name
  resource_group_name      = var.res_group_name
  location                 = var.res_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true

  static_website {
    index_document = var.index_document
  }
}

# Container for frontend
resource "azurerm_storage_container" "frontend_container" {
  name                  = "frontend"
  storage_account_name  = azurerm_storage_account.front_storage_acc.name
  # Public access
  container_access_type = "container"
}

#Add index.html to blob storage
resource "azurerm_storage_blob" "front_blob" {
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.front_storage_acc.name
  storage_container_name = azurerm_storage_container.frontend_container.name
  type                   = "Block"
  content_type           = "text/html"
  source                 = "${path.module}/MyFrontend/index.html"
}

#Add index.html to blob storage
resource "azurerm_storage_blob" "favicon_blob" {
  name                   = var.favicon
  storage_account_name   = azurerm_storage_account.front_storage_acc.name
  storage_container_name = azurerm_storage_container.frontend_container.name
  source                 = "${path.module}/MyFrontend/images/favicon.ico"
  type                   = "Block"
}