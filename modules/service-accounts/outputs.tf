output "email" {
  description = "Service-account email address."
  value       = google_service_account.this.email
}

output "unique_id" {
  description = "Google unique ID of the service account."
  value       = google_service_account.this.unique_id
}

output "resource_name" {
  description = "Service-account resource name."
  value       = google_service_account.this.name
}
