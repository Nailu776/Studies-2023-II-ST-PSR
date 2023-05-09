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

variable "images_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "imgsstorageacc1"
} 

variable "image_container_name" {
  type        = string
  description = "Name of upload container."
  default     = "images"
} 

variable "imgs_fun_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "imgsfunstorageacc1"
}

variable "imgs_fun_service_plan_name" {
  type        = string
  description = "Name of upload function service plan."
  default     = "imgs-fun-service-plan"
}

variable "imgs_fun_app_name" {
  type        = string
  description = "Name of upload function application."
  default     = "imgs-fun-app1"
}

variable "desc_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "descstorageacc1"
}

variable "desc_storage_table_name" {
  type        = string
  description = "Name of descs storage table."
  default     = "imagedescriptions"
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

variable "front_storage_account_name" {
  type        = string
  description = "Name of frontend storage account."
  default     = "frontstorageacc1"
} 

variable "frontend_container_name" {
  type        = string
  description = "Name of frontend container."
  default     = "frontend"
}

variable "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET" {
  description = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
  type        = string
  sensitive   = true
}
