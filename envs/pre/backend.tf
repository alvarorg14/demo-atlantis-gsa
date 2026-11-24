terraform {
  backend "gcs" {
    bucket                      = "alvarorg14-terraform-state-gsa-pre"
    prefix                      = "demo-atlantis-gsa/pre"
    impersonate_service_account = "terraform-gsas-pre@alvarorg14-demo-pre.iam.gserviceaccount.com"
  }
}
