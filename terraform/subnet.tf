resource "google_compute_subnetwork" "mysubnet" {
  name                     = "mysubnet"
  ip_cidr_range            = "10.0.0.0/24"
  network                  = "${google_compute_network.myvpc.self_link}"
  region                   = "${var.gcp_region}"
  private_ip_google_access = true
}
