variable "dns_zone_name" {
  description = "DNS public zone name"
  type        = string
  default     = "my-public-zone"
}

variable "dns_fqdn" {
  description = "DNS Zone based on FQDN"
  type        = string
}

variable "rs_fqdn" {
  description = "Recordset based on FQDN"
  type        = string
}

variable "rs_type" {
  description = "Type of a record set"
  type        = string
  default     = "A"
}

variable "rs_ttl" {
  description = "TTL of a record set (seconds)"
  type        = number
  default     = 200
}

variable "rs_data" {
  description = "The string data for the records in this record set"
  type        = list(string)
  default     = ["10.1.0.1"]
}
