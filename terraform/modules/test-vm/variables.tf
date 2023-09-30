variable "vm_name" {
  description = "Define a name for the VM"
  type        = string
  default     = "test-dumplings"
}

variable "vm_type" {
  description = "The type of VM"
  type        = string
  default     = "standard-v1"
}

variable "zone" {
  description = "Instance availability zone"
}

variable "vm_sched_pol" {
  description = "Scheduling policy"
  type        = map(any)
  default = {
    "preemptible" = false
  }
}

variable "vm_cores" {
  description = "CPU cores"
  type        = number
  default     = 2
}

variable "vm_memory" {
  description = "Memory in GB"
  type        = number
  default     = 4
}

variable "vm_image_id" {
  description = "The image ID for the VM"
  type        = string
  default     = "fd8dfofgv8k45mqv25nq"
}
variable "vm_boot_disk_size" {
  description = "The size of the disk in GB"
  type        = number
  default     = 30
}

variable "vm_nat" {
  description = "Provide a public address"
  type        = bool
  default     = true
}


variable "vm_network" {
  description = "Network name"
  type        = string
  default     = "mynet"
}
