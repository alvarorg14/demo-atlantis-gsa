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

module "missing_prefix_pre" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "policy-test-pre"
  display_name = "Policy test PRE"
  description  = "Negative test for the service account ID prefix policy"
}
