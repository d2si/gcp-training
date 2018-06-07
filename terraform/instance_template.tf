resource "google_compute_instance_template" "server" {
  name = "server"

  tags = ["server"]

  machine_type = "g1-small"

  disk {
    disk_size_gb = 10
    source_image = "debian-9"
    auto_delete  = true
    boot         = true
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.mysubnet.self_link}"

    access_config = {
      nat_ip = ""
    }
  }

  service_account {
    scopes = ["logging-write", "monitoring-write", "service-control", "service-management", "storage-ro"]
  }

  metadata_startup_script = <<STARTUP_SCRIPT
#!/bin/bash -e
curl -s -L -o /tmp/server https://github.com/d2si/gcp-training/releases/download/latest/server-linux-amd64 && chmod +x /tmp/server

cat > /etc/systemd/system/server.service <<EOF
[Unit]
Description=server
After=network.target

[Service]
Type=simple
User=nobody
WorkingDirectory=/tmp
ExecStart=/tmp/server
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload && systemctl start server
STARTUP_SCRIPT
}
