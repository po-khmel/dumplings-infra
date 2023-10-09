resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "po-khmel.space."
  type    = "A"
  ttl     = 200
}
