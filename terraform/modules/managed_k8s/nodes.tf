resource "yandex_kubernetes_node_group" "k8s-nodes" {
  cluster_id  = yandex_kubernetes_cluster.k8s-zonal.id
  description = "group of k8s nodes for dumplings project"
  version     = "1.24"

  instance_template {
    platform_id = "standard-v2"

    resources {
      memory = 2
      cores  = 2
    }

    boot_disk {
      type = "network-hdd"
      size = 64
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
      project = "dumplingstore"
    }

    scheduling_policy {
      preemptible = false
    }
  }

  scale_policy {
    fixed_scale {
      size = 1
    }
  }

  allocation_policy {
    location {
      zone = "ru-central1-a"
    }
  }
}
