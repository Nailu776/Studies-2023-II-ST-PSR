# Cognitive for ComputerVision
# Free 0 tier
resource "azurerm_cognitive_account" "cognitive_acc" {
  name                = "psr-cognitive-acc"
  resource_group_name = var.res_group_name
  location            = var.res_group_location
  kind                = "ComputerVision"
  sku_name            = "F0"
  
  tags = {
    Terraform = "true"
  }
}

# Storage acc for cognitive fun code
resource "azurerm_storage_account" "cognitive_fa_storage_acc" {
  name                     = var.cognitive_fa_storage_acc_name
  resource_group_name      = var.res_group_name
  location                 = var.res_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Service plan for cognitive function app
resource "azurerm_service_plan" "cognitive_fa_service_plan" {
  name                = "cognitive_fa_service_plan"
  resource_group_name = var.res_group_name
  location            = var.res_group_location
  os_type             = "Linux"
  sku_name            = "Y1"
}

# Function App for only cognitive service
resource "azurerm_linux_function_app" "cognitive_fun_app" {
  name                       = "cognitive-fa"
  resource_group_name        = var.res_group_name
  location                   = var.res_group_location
  service_plan_id            = azurerm_service_plan.cognitive_fa_service_plan.id
  storage_account_name       = azurerm_storage_account.cognitive_fa_storage_acc.name
  storage_account_access_key = azurerm_storage_account.cognitive_fa_storage_acc.primary_access_key

  app_settings = {
    # FUNCTIONS_WORKER_RUNTIME"       = "python"
    "IMGS_STORAGE_CONNECTION_STRING"  = var.imgs_storage_connection_string
    "DESC_STORAGE_CONNECTION_STRING"  = var.desc_storage_connection_string
    "DESC_STORAGE_TABLE_NAME"         = var.desc_storage_table_name
    "COGNITIVE_SERVICES_KEY"          = azurerm_cognitive_account.cognitive_acc.primary_access_key
    "COGNITIVE_SERVICES_ENDPOINT"     = azurerm_cognitive_account.cognitive_acc.endpoint
  }

  site_config {
    application_stack {
      python_version = 3.8
    }
    # cors {
    #   allowed_origins     = [
    #     "*"
    #   ]
    #   # support_credentials = false
    # }
  }

}
