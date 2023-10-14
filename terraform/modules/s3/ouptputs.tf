output "s3_images_bucket_name" {
  value = yandex_storage_bucket.s3-images.bucket
}

output "s3_state_bucket_name" {
  value = yandex_storage_bucket.s3-tf-state.bucket
}
