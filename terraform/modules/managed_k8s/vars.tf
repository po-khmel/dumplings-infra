variable "cloud_id" {
  description = "YC cloud ID"
  type        = string
}

variable "folder_id" {
  description = "YC folder ID"
  type        = string
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.24"
}

variable "sa_name" {
  description = "Name of a service account for managing k8s"
  type        = string
  default     = "k8s"
}
