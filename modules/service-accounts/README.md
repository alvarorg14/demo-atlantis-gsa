# Service accounts module

Creates one Google service account in the specified project. Declare a module block for each account. The `name` is the account ID and must satisfy the validation in `variables.tf`.

```hcl
module "demo_api_dev" {
  source       = "../../modules/service-accounts"
  project_id   = local.project_id
  name         = "demo-api-dev"
  display_name = "Demo API DEV"
  description  = "Demo API service account in DEV"
}
```

The `email`, `unique_id`, and `resource_name` outputs describe the account. No keys, IAM grants or other resources are created. `prevent_destroy` guards resources while this declaration exists; it is not an authorization boundary and removing the declaration removes the lifecycle rule. Execution identities lack delete and general update permissions, so metadata updates can fail. Renaming a module changes the resource address; use a reviewed `moved` block to preserve it. Changing an account ID can cause replacement. Use a separately reviewed privilege design for full lifecycle management.
