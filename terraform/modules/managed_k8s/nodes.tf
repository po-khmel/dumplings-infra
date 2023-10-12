resource "yandex_kubernetes_node_group" "k8s-nodes" {
  cluster_id  = yandex_kubernetes_cluster.k8s-zonal.id
  description = "group of k8s nodes for dumplings project"
  version     = var.k8s_version

  instance_template {
    platform_id = var.nodes_platform_id

    resources {
      memory = var.nodes_memory
      cores  = var.nodes_cpu
    }

    boot_disk {
      type = var.nodes_boot_disk_type
      size = var.nodes_boot_disk_size
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }

    network_interface {
      nat        = true
      subnet_ids = ["${yandex_vpc_subnet.mysubnet.id}"]
      security_group_ids = [
        yandex_vpc_security_group.k8s-main-sg.id,
        yandex_vpc_security_group.k8s-nodes-ssh-access.id,
        yandex_vpc_security_group.k8s-public-services.id
      ]
    }

    container_runtime {
      type = "containerd"
    }

    labels = {
      project = var.k8s_project_label
    }

    scheduling_policy {
      preemptible = var.nodes_scheduling_policy.preemptible
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = yandex_vpc_subnet.mysubnet.zone
    }
  }
}
