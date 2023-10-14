output "status_k8s_master" {
  value = module.yc_managed_k8s.status_k8s_master
}

output "status_k8s_node_group" {
  value = module.yc_managed_k8s.status_k8s_node_group
}

output "s3_images_bucket_name" {
  value = module.yc_s3.s3_images_bucket_name
}

output "s3_state_bucket_name" {
  value = module.yc_s3.s3_state_bucket_name
}

output "external_ip_dumplings_test_vm" {
  value = module.yc_test_vm_dumplings.external_ip_dumplings_test_vm
}
