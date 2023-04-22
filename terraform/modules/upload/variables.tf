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

variable "imgs_fun_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "imgsfunstorageacc"
}


variable "desc_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "descstorageacc"
}

variable "desc_storage_table_name" {
  type        = string
  description = "Name of upload storage table."
  default     = "imagedescriptions"
}

variable "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET" {
  description = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
  type        = string
  sensitive   = true
}