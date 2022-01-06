resource "yandex_lb_network_load_balancer" "lb" {
  name = "load-balancer"

  listener {
    name = "listener"
    port = 9292
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.app.id
    healthcheck {
      name     = "http"
      interval = 5
      http_options {
        port = 9292
      }
    }
  }

}
resource "yandex_lb_target_group" "app" {
  name      = "reddit-app-group"
  region_id = var.region_id

  dynamic "target" {
    for_each = yandex_compute_instance.app.*.network_interface.0.ip_address
    content {
      subnet_id = var.subnet_id
      address   = target.value
    }
  }
}
