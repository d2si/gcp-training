resource "google_service_account" "inventory" {
  account_id   = "inventory"
  display_name = "inventory"
}

resource "google_service_account_key" "inventory" {
  service_account_id = "${google_service_account.inventory.name}"
  public_key_type    = "TYPE_X509_PEM_FILE"
}

output "inventory_sa_credentials" {
  value     = "${base64decode(google_service_account_key.inventory.private_key)}"
  sensitive = true
}
