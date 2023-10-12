module "yc_network" {
  source       = "./modules/network"
  network_name = var.network_name
}

module "yc_managed_k8s" {
  source       = "./modules/managed_k8s"
  folder_id    = var.folder_id
  cloud_id     = var.cloud_id
  network_name = var.network_name
}

module "yc_s3" {
  source    = "./modules/s3"
  folder_id = var.folder_id
}

module "yc_test_vm_dumplings" {
  source     = "./modules/test-vm"
  zone       = var.zone
  vm_network = var.network_name
}

module "yc_dns" {
  source   = "./modules/dns"
  dns_fqdn = var.FQDN
  rs_fqdn  = var.FQDN
}
