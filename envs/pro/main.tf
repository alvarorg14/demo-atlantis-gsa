locals {
  project_id = "alvarorg14-demo-pro"
}

module "demo_api_pro" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-api-pro"
  display_name = "Demo API PRO"
  description  = "Demo API service account in PRO"
}
