resource "yandex_compute_disk" "storage" {
  count   = var.disk_count
  name  = "disk-${count.index + 1}"
  size  = 1
}

resource "yandex_compute_instance" "storage" {
  name = "storage"
  resources {
    cores = var.disk_cores
    memory = var.disk_memory
    core_fraction = var.disk_core
  }

  boot_disk {
    initialize_params {
    image_id = data.yandex_compute_image.ubuntu.image_id
        }
  }

  dynamic "secondary_disk" {
   for_each =  yandex_compute_disk.storage
   content {
     disk_id = secondary_disk.value.id
   }
  }

  network_interface {
     subnet_id = yandex_vpc_subnet.develop.id
     nat     = var.nat
  }

  metadata = {
    serial-port-enable = var.meta_serial
    ssh-keys = "ubuntu:${var.vms_ssh_root_key}"
  }
}
