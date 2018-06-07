resource "google_compute_global_address" "mylb" {
  name = "mylb"
}

# LB Backend
resource "google_compute_backend_service" "mylb" {
  name        = "mybackend"
  port_name   = "http"
  protocol    = "HTTP"
  timeout_sec = 3

  backend {
    group                 = "${google_compute_instance_group_manager.server.instance_group}"
    balancing_mode        = "RATE"
    max_rate_per_instance = "50"
  }

  health_checks                   = ["${google_compute_http_health_check.http_8000.self_link}"]
  connection_draining_timeout_sec = 60
}

resource "google_compute_url_map" "mylb" {
  name            = "mylb"
  default_service = "${google_compute_backend_service.mylb.self_link}"
}

resource "google_compute_target_http_proxy" "mylb" {
  name    = "mylb-target-proxy"
  url_map = "${google_compute_url_map.mylb.self_link}"
}

# LB frontend
resource "google_compute_global_forwarding_rule" "mylb" {
  name       = "mylb-forwarding-rule"
  target     = "${google_compute_target_http_proxy.mylb.self_link}"
  ip_address = "${google_compute_global_address.mylb.address}"
  port_range = "80"
}

output "mylb_external_ip_address" {
  value = "${google_compute_global_address.mylb.address}"
}
