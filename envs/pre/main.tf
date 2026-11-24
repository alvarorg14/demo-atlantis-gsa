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

module "demo_long_name_pre" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-intentionally-very-long-service-account-name-pre"
  display_name = "Demo long name policy test PRE"
  description  = "Negative test for the service account ID length policy"
}
