output "external_ip_dumplings_test_vm" {
  value = yandex_compute_instance.test-dumplings.network_interface.0.nat_ip_address
}
