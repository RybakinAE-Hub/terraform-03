resource "yandex_compute_instance" "vm-for_each" {
  depends_on = [yandex_compute_instance.web]
#  for_each = {for vm, value in var.fore_each-vm : vm => value}
for_each = { for vm in var.for_each-vm : "${vm.name}" => vm }
  name = each.value ["name"]
  platform_id = var.platform_id
  resources {
        cores           = each.value ["cores"]
        memory          = each.value ["memory"]
        core_fraction   = each.value ["core_fraction"]
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
  }

  metadata = {
    serial-port-enable = var.meta_serial
    ssh-keys           = "ubuntu:${local.ssh_key}"
  } 
}
