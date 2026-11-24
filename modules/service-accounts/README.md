# Service accounts module

Creates one Google service account in the specified project. Declare a module block for each account. The `name` is the account ID and must satisfy the validation in `variables.tf`.

```hcl
module "demo_api_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-api-dev"
  display_name = "Demo API DEV"
  description  = "Demo API service account in DEV"
  roles        = ["roles/logging.logWriter", "roles/monitoring.metricWriter"]
}
```

`roles` is an optional list of project-level IAM roles; it defaults to `[]`. Each distinct role is granted to the service account in `project_id` using a non-authoritative IAM member resource. Removing a role removes that managed grant. The runner needs permission to read and update the project's IAM policy, in addition to service-account administration permissions. No keys are created.

The `email`, `unique_id`, and `resource_name` outputs describe the account. `prevent_destroy` blocks destruction or replacement while the module block remains. Removing the module block also removes that protection and plans deletion of the account and its managed role grants. Renaming a module changes the resource address; use a reviewed `moved` block to preserve it.
