resource "yandex_dns_zone" "zone1" {
  name        = "my-public-zone"
  description = "Public zone"

  labels = {
    dns-zone = "public"
  }

  zone   = "pokhmel.online."
  public = true
}

resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "pokhmel.online."
  type    = "A"
  ttl     = 200
  data    = ["10.1.0.1"]
}
