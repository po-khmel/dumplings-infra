variable "sa-s3" {
  description = "Name of Service Account for managing S3"
  type        = string
  default     = "sa-s3"
}

variable "s3_images_name" {
  description = "Name of S3 bucket for images"
  type        = string
  default     = "std-017-042-dumpling-images"
}

variable "s3_state_name" {
  description = "Name of S3 bucket to store terraform state file"
  type        = string
  default     = "std-017-042-dumpling-tf-state"
}

variable "folder_id" {
  description = "YC folder ID"
  type        = string
}
