module "demo_lock_test_second_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-lock-test-second-dev"
  display_name = "Demo Lock Test Second DEV"
  description  = "Second DEV account for Atlantis lock testing"
}
