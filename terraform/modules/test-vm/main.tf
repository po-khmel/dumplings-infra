resource "yandex_compute_instance" "test-dumplings" {
  name        = var.vm_name
  description = "Test VM to deploy dumplings store"
  zone        = var.zone
  platform_id = var.vm_type

  resources {
    cores  = var.vm_cores
    memory = var.vm_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
      size     = var.vm_boot_disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.test-dumplings-subnet.id
    nat       = var.vm_nat
  }

  scheduling_policy {
    preemptible = var.vm_sched_pol.preemptible
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
