module "demo_lock_test_first_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-lock-test-first-dev"
  display_name = "Demo Lock Test First DEV"
  description  = "First DEV account for Atlantis lock testing"
}
