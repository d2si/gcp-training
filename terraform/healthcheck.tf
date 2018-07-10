resource "google_compute_http_health_check" "http_8000" {
  name                = "http-8000"
  request_path        = "/"
  port                = "8000"
  check_interval_sec  = 3
  timeout_sec         = 1
  healthy_threshold   = 2
  unhealthy_threshold = 3

  depends_on = ["google_compute_firewall.gclb-server"]
}
