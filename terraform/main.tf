module "yc_managed_k8s" {
  source    = "./modules/managed_k8s"
  folder_id = var.folder_id
  cloud_id  = var.cloud_id
}

module "yc_s3" {
  source    = "./modules/s3"
  folder_id = var.folder_id
}
