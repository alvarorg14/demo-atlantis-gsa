terraform {
  backend "gcs" {
    bucket                      = "alvarorg14-terraform-state-gsa-pro"
    prefix                      = "demo-atlantis-gsa/pro"
    impersonate_service_account = "terraform-gsas-pro@alvarorg14-demo-pro.iam.gserviceaccount.com"
  }
}
