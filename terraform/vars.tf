variable "cloud_id" {
  description = "YC cloud ID"
  type        = string
}

variable "folder_id" {
  description = "YC folder ID"
  type        = string
}

variable "zone" {
  description = "Default zone name"
  type        = string
  default     = "ru-central1-a"
}

variable "token" {
  description = "OAuth YC token"
  type        = string
}

#add network_name var to k8s etc
variable "network_name" {
  description = "Network name"
  type        = string
  default     = "mynet"
}

variable "FQDN" {
  description = "FQDN for the Momo store"
  type        = string
  default     = "po-khmel.space"
}
