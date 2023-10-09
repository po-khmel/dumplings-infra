resource "yandex_cm_certificate" "le-certificate" {
  name    = "Dumplings k8s certificate"
  domains = ["${var.fqdn}"]

  managed {
    challenge_type = var.challenge_type
  }
}
