resource "yandex_cm_certificate" "le-certificate" {
  name    = "Dumplings k8s certificate"
  domains = ["po-khmel.space"]

  managed {
    challenge_type = "DNS_CNAME"
  }
}
