locals {
  ssh_key = file("~/.ssh/id_ed25519.pub")
}

locals {
    web = yandex_compute_instance.web.*
    db = yandex_compute_instance.vm-for_each
    storage = yandex_compute_instance.storage.* 
}