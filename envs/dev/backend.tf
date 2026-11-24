terraform {
  backend "gcs" {
    bucket                      = "alvarorg14-terraform-state-gsa-dev"
    prefix                      = "demo-atlantis-gsa/dev"
    impersonate_service_account = "terraform-gsas-dev@alvarorg14-demo-dev.iam.gserviceaccount.com"
  }
}
