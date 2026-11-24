locals {
  project_id = "alvarorg14-demo-pre"
}

module "demo_api_pre" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-api-pre"
  display_name = "Demo API PRE"
  description  = "Demo API service account in PRE"
}

module "demo_worker_pre" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-worker-pre"
  display_name = "Demo Worker PRE"
  description  = "Demo worker service account in PRE"
}
