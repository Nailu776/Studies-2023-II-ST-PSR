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

variable "upload_storage_account_name" {
  type        = string
  description = "Name of upload storage account."
  default     = "uploadfunstorageacc"
}

variable "cognitive_fa_storage_acc_name" {
  type        = string
  description = "Name of cognitive storage account."
  default     = "cognitivefunstorageacc"
}

variable "desc_storage_table_name" {
  type        = string
  description = "Name of upload storage table."
  default     = "imagedescriptions"
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