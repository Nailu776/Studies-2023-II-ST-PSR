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
  default     = "imgsstorageacc"
} 

variable "image_container_name" {
  type        = string
  description = "Name of upload container."
  default     = "images"
} 

variable "imgs_fun_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "imgsfunstorageacc"
}

variable "imgs_fun_service_plan_name" {
  type        = string
  description = "Name of upload function service plan."
  default     = "imgs-fun-service-plan"
}

variable "imgs_fun_app_name" {
  type        = string
  description = "Name of upload function application."
  default     = "imgs-fun-app"
}

variable "desc_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "descstorageacc"
}

variable "desc_storage_table_name" {
  type        = string
  description = "Name of descs storage table."
  default     = "imagedescriptions"
}

variable "cognitive_fa_storage_acc_name" {
  type        = string
  description = "Name of cognitive storage account."
  default     = "cognitivefunstorageacc"
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
  default     = "cognitive-fa"
}

variable "front_storage_account_name" {
  type        = string
  description = "Name of frontend storage account."
  default     = "frontstorageacc"
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
