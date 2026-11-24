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
  assert {
    condition     = length(google_project_iam_member.roles) == 0
    error_message = "No project roles should be granted by default."
  }
}

run "grants_project_roles" {
  command = apply
  variables {
    roles = ["roles/logging.logWriter", "roles/monitoring.metricWriter", "roles/logging.logWriter"]
  }
  assert {
    condition = length(google_project_iam_member.roles) == 2 && alltrue([
      for role, grant in google_project_iam_member.roles :
      grant.project == var.project_id && grant.role == role && grant.member == "serviceAccount:${google_service_account.this.email}"
    ])
    error_message = "Each distinct role should be granted to the service account in the configured project."
  }
}

run "rejects_invalid_account_id" {
  command = plan
  variables {
    name = "invalid"
  }
  expect_failures = [var.name]
}
