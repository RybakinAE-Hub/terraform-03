
data "yandex_compute_image" "ubuntu" {
  family = var.count_family
}
  resource "yandex_compute_instance" "web" {
    count = var.count_count
    name  = "web-${count.index + 1}"
    platform_id = var.platform_id
  resources {
    cores         = var.count_cores
    memory        = var.count_memory
    core_fraction = var.count_core
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = var.preemptible
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.nat
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    serial-port-enable = var.meta_serial
    ssh-keys           = "ubuntu:${local.ssh_key}"
  } 
}