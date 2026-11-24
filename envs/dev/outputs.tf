output "service_account_emails" {
  description = "Created service-account emails."
  value = {
    "demo-api-dev" = module.demo_api_dev.email
  }
}
