variable "fqdn" {
  description = "Domain Name"
  type        = string
  default     = "po-khmel.space"
}

variable "dns-zone" {
  description = "Domain Zone"
  type        = string
  default     = "po-khmel1.space"
}

variable "domain-zone-name" {
  description = "Domain Zone Name"
  type        = string
  default     = "my-public-zone"
}

variable "labels" {
  description = "Labels to assign to DNS zone"
  type = object({
    name = string
  })
  default = {
    type = "public"
  }
}

variable "challenge_type" {
  description = "Challenge typr for Lets'Encrypt certificates"
  type        = string
  default     = "DNS_CNAME"
}
