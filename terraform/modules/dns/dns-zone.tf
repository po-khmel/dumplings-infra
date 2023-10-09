resource "yandex_dns_zone" "zone1" {
  name        = "my-public-zone"
  description = "Public zone for dumplings k8s cluster"

  labels = {
    type = "public"
  }

  zone   = "po-kheml1.space."
  public = true
}
