resource "google_project_iam_custom_role" "inventory" {
  role_id     = "inventory"
  title       = "Inventory"
  permissions = ["compute.instances.list", "compute.firewalls.list"]
}

resource "google_project_iam_binding" "inventory" {
  role = "projects/${var.gcp_project}/roles/${google_project_iam_custom_role.inventory.role_id}"

  members = ["serviceAccount:${google_service_account.inventory.email}"]
}
