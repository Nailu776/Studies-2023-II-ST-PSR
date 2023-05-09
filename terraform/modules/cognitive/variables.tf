variable "res_group_name" {
  type        = string
  description = "Name of resource group."
  default     = "terraform-psr2023-resources"
}

variable "res_group_location" {
  type        = string
  description = "Location of resource group."
  default     = "West Europe"
}

variable "cognitive_fa_storage_acc_name" {
  type        = string
  description = "Name of cognitive storage account."
  default     = "cognitivefunstorageacc1"
}

variable "azurerm_cognitive_account_name" {
  type        = string
  description = "Name of cognitive account."
  default     = "psr-cognitive-acc"
}

variable "cognitive_fa_service_plan_name" {
  type        = string
  description = "Name of cognitive fa service plan."
  default     = "cognitive_fa_service_plan"
}

variable "cognitive_fun_app_name" {
  type        = string
  description = "Name of cognitive cognitive fun app."
  default     = "cognitive-fa1"
}


variable "desc_storage_table_name" {
  type        = string
  description = "Name of upload storage table."
}

variable "imgs_storage_connection_string" {
  type        = string
  description = "The connection string for the imgs storage account"
  sensitive = true
}

variable "desc_storage_connection_string" {
  type        = string
  description = "The connection string for the desc storage account"
  sensitive = true
}