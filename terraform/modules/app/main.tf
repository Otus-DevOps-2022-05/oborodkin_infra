resource "yandex_compute_instance" "app" {
  name = "reddit-app"

  labels = {
    tags = "reddit-app"
  }

  resources {
    core_fraction = var.core_fraction
    cores         = var.res_cores
    memory        = var.res_memory
  }

  boot_disk {
    initialize_params {
      image_id = var.app_disk_image
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 60s"
    ]
  }

  provisioner "file" {
    content     = templatefile("${path.module}/puma.service.tftpl", { database_ip_address = var.database_ip_address })
    destination = "/tmp/puma.service"
  }

  # искуственная задержка, что Ubuntu успела обновиться
  provisioner "remote-exec" {
    inline = [
      "sleep 60s"
    ]
  }

  provisioner "remote-exec" {
    script = "${path.module}/deploy.sh"
  }
}
