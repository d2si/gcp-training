resource "google_compute_firewall" "gclb-server" {
  name    = "allow-server-from-gclb"
  network = "${google_compute_network.myvpc.self_link}"

  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]

  allow {
    protocol = "tcp"
    ports    = ["8000"]
  }

  target_tags = ["server"]
}

resource "google_compute_firewall" "ssh" {
  name    = "allow-ssh-server"
  network = "${google_compute_network.myvpc.self_link}"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["server"]
}
