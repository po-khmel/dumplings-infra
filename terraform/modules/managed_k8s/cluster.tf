resource "yandex_kubernetes_cluster" "k8s-zonal" {
  name        = var.k8s_name
  description = "k8s cluster for dumplings project"
  network_id  = data.yandex_vpc_network.mynet.id

  master {
    version = var.k8s_version

    zonal {
      zone      = yandex_vpc_subnet.mysubnet.zone
      subnet_id = yandex_vpc_subnet.mysubnet.id
    }

    public_ip = true
    security_group_ids = [
      yandex_vpc_security_group.k8s-main-sg.id,
      yandex_vpc_security_group.k8s-master-whitelist.id
    ]
  }

  service_account_id      = yandex_iam_service_account.myaccount.id
  node_service_account_id = yandex_iam_service_account.myaccount.id

  labels = {
    project = var.k8s_project_label
  }

  release_channel = var.k8s_release_channel

  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s-clusters-agent,
    yandex_resourcemanager_folder_iam_member.vpc-public-admin,
    yandex_resourcemanager_folder_iam_member.images-puller
  ]

  kms_provider {
    key_id = yandex_kms_symmetric_key.kms-key.id
  }
}
