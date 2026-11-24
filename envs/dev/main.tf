locals {
  project_id = "alvarorg14-demo-dev"
}

module "demo_api_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-api-dev"
  display_name = "Demo API DEV"
  description  = "Demo API service account in DEV"
}

module "demo_observability_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-observability-dev"
  display_name = "Demo Observability DEV"
  description  = "Demo observability service account in DEV"
  roles        = ["roles/logging.logWriter", "roles/monitoring.metricWriter"]
}

# Temporary plan-only verification of the server-controlled Atlantis policy.
module "demo_policycheck_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-policycheck-dev"
  display_name = "Demo policy check DEV"
  description  = "Disposable Atlantis policy-check test"
}
