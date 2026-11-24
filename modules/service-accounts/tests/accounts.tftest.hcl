mock_provider "google" {}

variables {
  project_id   = "example-project"
  name         = "demo-api"
  display_name = "Demo API"
  description  = "API service account"
}

run "creates_account" {
  command = plan
  assert {
    condition     = google_service_account.this.project == "example-project" && google_service_account.this.account_id == "demo-api" && google_service_account.this.display_name == "Demo API" && google_service_account.this.description == "API service account"
    error_message = "Expected the configured account in the specified project."
  }
}

run "rejects_invalid_account_id" {
  command = plan
  variables {
    name = "invalid"
  }
  expect_failures = [var.name]
}
