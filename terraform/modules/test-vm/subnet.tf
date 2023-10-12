resource "yandex_vpc_subnet" "test-dumplings-subnet" {
  name           = "test-dumplings-subnet"
  zone           = var.zone
  network_id     = data.yandex_vpc_network.mynet.id
  v4_cidr_blocks = ["10.5.0.0/24"]
}
