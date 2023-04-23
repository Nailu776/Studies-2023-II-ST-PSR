# Resource group called "terraform-project-resources"
resource "azurerm_resource_group" "psr2023_res" {
  name     = var.res_group_name
  location = var.res_group_location
}

module "upload" {
  depends_on = [
    azurerm_resource_group.psr2023_res
  ]
  source = "./modules/upload"
  # Generic
  res_group_name      = var.res_group_name
  res_group_location  = var.res_group_location
  # Storage acc specific 
  desc_storage_table_name       = var.desc_storage_table_name
  desc_storage_account_name     = var.desc_storage_account_name
  images_storage_account_name   = var.images_storage_account_name
  imgs_fun_storage_account_name = var.imgs_fun_storage_account_name
  MICROSOFT_PROVIDER_AUTHENTICATION_SECRET = var.MICROSOFT_PROVIDER_AUTHENTICATION_SECRET
}

module "cognitive" {
  source = "./modules/cognitive"
  # Generic
  res_group_name = var.res_group_name
  res_group_location = var.res_group_location
  # Storage acc specific 
  cognitive_fa_storage_acc_name   = var.cognitive_fa_storage_acc_name
  imgs_storage_connection_string  = module.upload.imgs_storage_connection_string
  desc_storage_connection_string  = module.upload.desc_storage_connection_string
  desc_storage_table_name         = var.desc_storage_table_name
  # Wait for storage account for data to create
  depends_on = [
    module.upload
  ]
}

module "front" {
  source = "./modules/front"
  depends_on = [
    azurerm_resource_group.psr2023_res
  ]
  # Generic
  res_group_name = var.res_group_name
  res_group_location = var.res_group_location
}
