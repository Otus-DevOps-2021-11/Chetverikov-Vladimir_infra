provider "yandex" {
  service_account_key_file = var.service_account_key_file
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "app" {
  name = "reddit-app-${count.index}"
  count = var.instances_count
  zone = var.zone

  resources {
    # Количество ядер увеличено с 1 до 2, т.к. для значения по умолчанию platform_id = "standard-v1" доступное количество ядер 2, 4, 6, 8 и т.д.
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указан id образа созданного в предыдущем домашем задании (yc compute image list)
      image_id = var.image_id
    }
  }

  network_interface {
    # id подсети default-ru-central1-a из консоли
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
  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
