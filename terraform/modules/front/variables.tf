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

variable "front_storage_account_name" {
  type        = string
  description = "Name of frontend storage account."
  default     = "frontstorageacc"
} 

variable "index_document" {
  description = "The index document of the static website"
  default ="index.html"
}

variable "favicon" {
  description = "The index document of the static website"
  default ="favicon.ico"
}
