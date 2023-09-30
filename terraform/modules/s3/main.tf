# create buckets using sa-static-key
resource "yandex_storage_bucket" "s3-images" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.s3_images_name
  acl        = "public-read"
}

resource "yandex_storage_bucket" "s3-tf-state" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = var.s3_state_name
  acl        = "private"
}
