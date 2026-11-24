output "service_account_emails" {
  description = "Created service-account emails."
  value = {
    "demo-api-dev"           = module.demo_api_dev.email
    "demo-worker-dev"        = module.demo_worker_dev.email
    "demo-observability-dev" = module.demo_observability_dev.email
  }
}
