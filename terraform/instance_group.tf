resource "google_compute_instance_group_manager" "server" {
  name = "server"

  base_instance_name = "server"
  instance_template  = "${google_compute_instance_template.server.self_link}"
  update_strategy    = "NONE"
  zone               = "${var.gcp_zone}"

  auto_healing_policies {
    health_check      = "${google_compute_http_health_check.http_8000.self_link}"
    initial_delay_sec = 60
  }

  named_port {
    name = "http"
    port = 8000
  }
}

resource "google_compute_autoscaler" "server" {
  name   = "scaler"
  zone   = "${var.gcp_zone}"
  target = "${google_compute_instance_group_manager.server.self_link}"

  autoscaling_policy = {
    min_replicas    = 1
    max_replicas    = 10
    cooldown_period = 60

    cpu_utilization {
      target = 0.6
    }
  }
}
