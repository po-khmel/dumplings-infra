### general ###
variable "cloud_id" {
  description = "YC cloud ID"
  type        = string
}

variable "folder_id" {
  description = "YC folder ID"
  type        = string
}

variable "network_name" {
  description = "Network name"
  type        = string
  default     = "mynet"
}

variable "k8s_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.24"
}

variable "k8s_project_label" {
  description = "Name of the project"
  type        = string
  default     = "dumplingstore"
}

### k8s master ###

variable "sa_name" {
  description = "Name of a service account for managing k8s"
  type        = string
  default     = "k8s"
}

variable "k8s_name" {
  description = "Name of k8s zonal cluster"
  type        = string
  default     = "k8s-dumplings"
}

variable "k8s_release_channel" {
  description = "k8s release channel"
  type        = string
  default     = "RAPID"
}
### k8s nodes ###

variable "nodes_platform_id" {
  description = "ID of the platform for k8s nodes templates"
  type        = string
  default     = "standard-v2"
}

variable "nodes_memory" {
  description = "Memory in GB for k8s nodes"
  type        = number
  default     = 2
}

variable "nodes_cpu" {
  description = "CPU for k8s nodes"
  type        = number
  default     = 2
}

variable "nodes_boot_disk_type" {
  description = "k8s nodes boot disk type"
  type        = string
  default     = "network-hdd"
}

variable "nodes_boot_disk_size" {
  description = "k8s nodes boot disk size"
  type        = number
  default     = 64
}

variable "nodes_container_runtime" {
  description = "k8s nodes container runtime"
  type        = string
  default     = "containerd"
}

variable "nodes_scheduling_policy" {
  description = "k8s nodes cheduling policy"
  type        = map(any)
  default = {
    "preemptible" = false
  }
}

variable "nodes_fixed_scale" {
  description = "Number of instances to scale up and down group of k8s nodes"
  type        = number
  default     = 1
}


