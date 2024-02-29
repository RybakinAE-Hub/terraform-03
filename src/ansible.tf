resource "local_file" "inventory_cfg" {
  content = templatefile("${path.module}/inventory.tftpl",
    { 
    web =  yandex_compute_instance.web,
    db =  yandex_compute_instance.db, 
    storage =  [yandex_compute_instance.storage]   
    }  
)
  filename = "${abspath(path.module)}/inventory"


resource "null_resource" "web_hosts_provision" {
depends_on = [yandex_compute_instance.storage, local_file.inventory_cfg]
  provisioner "local-exec" {
    command = "cat ~/.ssh/id_ed25519 | ssh-add -"
  }
 provisioner "local-exec" {
    command = "sleep 60"
  }
  provisioner "local-exec" {                  
    command  = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
  }
    triggers = {  
      always_run         = "${timestamp()}" 
      playbook_src_hash  = file("${abspath(path.module)}/test.yml") 
      ssh_public_key     = var.vms_ssh_root_key 
    }
}
}