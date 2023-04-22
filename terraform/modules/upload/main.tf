# Storage Acc for images
resource "azurerm_storage_account" "imgs_storage_acc" {
  name                     = var.images_storage_account_name
  resource_group_name      = var.res_group_name
  location                 = var.res_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Container for images
resource "azurerm_storage_container" "image_container" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.imgs_storage_acc.name
  container_access_type = "container"
}

# Storage acc for image descriptions
resource "azurerm_storage_account" "desc_storage_acc" {
  name                     = var.desc_storage_account_name
  resource_group_name      = var.res_group_name
  location                 = var.res_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage table for image descriptions
resource "azurerm_storage_table" "desc_storage_table" {
  name                 = var.desc_storage_table_name
  storage_account_name = azurerm_storage_account.desc_storage_acc.name
}

# Storage Acc for images function app code
resource "azurerm_storage_account" "imgs_fun_storage_acc" {
  name                     = var.imgs_fun_storage_account_name
  resource_group_name      = var.res_group_name
  location                 = var.res_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Service plan for App Function
resource "azurerm_service_plan" "imgs_fun_service_plan" {
  name                = "imgs-fun-service-plan"
  resource_group_name = var.res_group_name
  location            = var.res_group_location
  os_type             = "Linux"
  sku_name            = "Y1"
}

# Function app for upload and download images
resource "azurerm_linux_function_app" "imgs_fun_app" {
  name                       = "imgs-fun-app"
  resource_group_name        = var.res_group_name
  location                   = var.res_group_location
  service_plan_id            = azurerm_service_plan.imgs_fun_service_plan.id
  storage_account_name       = azurerm_storage_account.imgs_fun_storage_acc.name
  storage_account_access_key = azurerm_storage_account.imgs_fun_storage_acc.primary_access_key

  app_settings = {
    # FUNCTIONS_WORKER_RUNTIME"                 = "python"
    "IMGS_STORAGE_CONNECTION_STRING"            = azurerm_storage_account.imgs_storage_acc.primary_connection_string
    "DESC_STORAGE_CONNECTION_STRING"            = azurerm_storage_account.desc_storage_acc.primary_connection_string
    "DESC_STORAGE_TABLE_NAME"                   = azurerm_storage_table.desc_storage_table.name
    "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"  = var.MICROSOFT_PROVIDER_AUTHENTICATION_SECRET
  }

  site_config {
    application_stack {
      python_version = 3.8
    }
    cors {
      allowed_origins     = [
        "https://frontstorageacc.blob.core.windows.net"
      ]
      support_credentials = false
    }
  }

  auth_settings_v2 {
    auth_enabled             = true
    excluded_paths           = []
    forward_proxy_convention = "NoProxy"
    http_route_api_prefix    = "/.auth"
    require_authentication   = true
    require_https            = true
    runtime_version          = "~1"
    unauthenticated_action   = "Return401"

    active_directory_v2 {
        allowed_applications            = []
        allowed_audiences               = []
        allowed_groups                  = []
        allowed_identities              = []
        client_id                       = "27d877fa-232c-4c9c-9297-b81f27cb2e6a"
        client_secret_setting_name      = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
        jwt_allowed_client_applications = []
        jwt_allowed_groups              = []
        login_parameters                = {}
        tenant_auth_endpoint            = "https://login.microsoftonline.com/common/v2.0"
        www_authentication_disabled     = false
    }

    login {
        allowed_external_redirect_urls    = []
        cookie_expiration_convention      = "FixedTime"
        cookie_expiration_time            = "08:00:00"
        nonce_expiration_time             = "00:05:00"
        preserve_url_fragments_for_logins = false
        token_refresh_extension_time      = 72
        token_store_enabled               = true
        validate_nonce                    = true
    }
  }

  sticky_settings {
    app_setting_names       = [
        "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET",
      ] 
  }
}
