output "status_k8s_master" {
  value = yandex_kubernetes_cluster.k8s-zonal.status
}

output "status_k8s_node_group" {
  value = yandex_kubernetes_node_group.k8s-nodes.status
}
