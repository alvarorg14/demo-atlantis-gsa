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
