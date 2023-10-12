resource "yandex_dns_zone" "zone1" {
  name        = var.domain-zone-name
  description = "Public zone for dumplings k8s cluster"

  labels = var.labels

  zone   = "${dns-zone}."
  public = true
}
