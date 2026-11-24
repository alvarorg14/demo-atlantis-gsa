resource "google_service_account" "this" {
  project      = var.project_id
  account_id   = var.name
  display_name = var.display_name
  description  = var.description

  lifecycle {
    prevent_destroy = true
  }
}
