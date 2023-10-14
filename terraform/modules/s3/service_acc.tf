# create SA 
resource "yandex_iam_service_account" "sa-s3" {
  name = var.sa-s3
}

# assign storage.editor role to SA
resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa-s3.id}"
}

# create static key for storage
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa-s3.id
  description        = "static access key for object storage"
}
