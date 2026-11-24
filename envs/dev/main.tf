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

module "demo_worker_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-worker-dev"
  display_name = "Demo Worker DEV"
  description  = "Background worker in DEV"
}
