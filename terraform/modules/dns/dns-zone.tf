resource "yandex_dns_zone" "zone1" {
  name        = var.dns_zone_name
  description = "Public zone"

  labels = {
    dns-zone = "public"
  }

  zone   = "${var.dns_fqdn}."
  public = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "${var.rs_fqdn}."
  type    = var.rs_type
  ttl     = var.rs_ttl
  data    = var.rs_data
}
