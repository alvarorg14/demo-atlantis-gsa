output "service_account_emails" {
  description = "Created service-account emails."
  value = {
    "demo-api-pre" = module.demo_api_pre.email
  }
}
