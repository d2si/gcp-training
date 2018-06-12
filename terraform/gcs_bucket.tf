resource "google_storage_bucket" "inventory_bucket" {
  name          = "${var.gcp_project}-inventory"
  storage_class = "REGIONAL"
  location      = "${var.gcp_region}"
}

resource "google_storage_bucket_iam_binding" "inventory_bucket" {
  bucket = "${google_storage_bucket.inventory_bucket.name}"
  role   = "roles/storage.admin"

  members = ["serviceAccount:${google_service_account.inventory.email}"]
}
