# demo-atlantis-gsa

This repository declares Google Cloud service accounts (GSAs) with one reusable Terraform module and three independent environments. The existing [demo-atlantis-setup](https://github.com/alvarorg14/demo-atlantis-setup) supplies the Atlantis runtimes, execution identities, state buckets and server-side rules; this repository does not provision or change them. The example accounts are intended for the first controlled Atlantis PR, not automatically created by this repository.

| Environment | GCP project | Execution identity | GCS bucket / prefix | Atlantis project |
| --- | --- | --- | --- | --- |
| DEV | `alvarorg14-demo-dev` | `terraform-gsas-dev@alvarorg14-demo-dev.iam.gserviceaccount.com` | `alvarorg14-terraform-state-gsa-dev` / `demo-atlantis-gsa/dev` | `dev-gsas` |
| PRE | `alvarorg14-demo-pre` | `terraform-gsas-pre@alvarorg14-demo-pre.iam.gserviceaccount.com` | `alvarorg14-terraform-state-gsa-pre` / `demo-atlantis-gsa/pre` | `pre-gsas` |
| PRO | `alvarorg14-demo-pro` | `terraform-gsas-pro@alvarorg14-demo-pro.iam.gserviceaccount.com` | `alvarorg14-terraform-state-gsa-pro` / `demo-atlantis-gsa/pro` | `pro-gsas` |

Atlantis authenticates as its VM runtime identity; both the GCS backend and Google provider explicitly impersonate the environment's execution identity. Each root has its own remote state and lock file and uses the default workspace. Nonproduction and production run on separate Atlantis instances. DEV and PRE share the nonproduction runtime trust boundary. See [security](docs/security.md) for the limits of these controls.

```text
modules/service-accounts/  shared GSA module and mock tests
envs/{dev,pre,pro}/       independent Terraform roots
atlantis-{nonprod,prod}.yaml  Atlantis project selection
.github/                  ownership and CI
docs/                     security and operations
tests/                    integration test checklist
```

## Making changes

1. Create a branch from `main` and add one module block for the account in the appropriate `envs/<environment>/main.tf`. IDs must be 6–30 characters and match `demo-[a-z][a-z0-9-]*[a-z0-9]`. Add the new module’s `email` output to the environment’s `service_account_emails` output if it should appear there; see the existing blocks for examples.
2. Run the local validation below and open a PR targeting `main`. Both Atlantis GitHub Apps must be installed on this repository. DEV/PRE changes normally trigger the matching nonproduction plan; shared module changes trigger both.
3. Review the plan, including project and all additions, updates and removals. An authorized user comments `atlantis-nonprod apply -p dev-gsas` or `atlantis-nonprod apply -p pre-gsas` as appropriate. Apply requires the existing server's mergeable and undiverged checks.
4. For PRO, obtain the required independent approval first, then comment `atlantis-prod plan -p pro-gsas`, review the plan, and comment `atlantis-prod apply -p pro-gsas`. Production planning requires approval; applying also requires mergeability and an undiverged branch. Merge only after the intended apply succeeds.

To change an existing account, edit its module arguments and review the resulting plan. The existing execution identity has the create role, not general service-account administration: updates to display name or description may fail. Do not assume metadata changes are supported or add permissions here. Renaming a module changes its Terraform address; changing the account ID can cause a replacement. Use a reviewed `moved` block when renaming a module to preserve the address; destruction is blocked by `prevent_destroy` while the resource declaration remains present, and by the execution identity's lack of delete permission. See [operations](docs/operations.md) before imports, recovery or changes affecting an existing GSA.

Protect `main` with required PRs, passing CI, reviews for production, stale approval dismissal and restrictions on direct and force pushes. Configure required CODEOWNERS review where appropriate. The initial CODEOWNERS is the repository owner; a second collaborator is needed for genuine independent approval because a PR author cannot approve their own PR. These settings and GitHub App installation are external prerequisites and are not configured by this code.

## Local validation

Install Terraform 1.17.2, then run without GCP credentials or access to state:

```sh
terraform fmt -check -recursive
for env in dev pre pro; do
  terraform -chdir="envs/$env" init -backend=false -input=false -lockfile=readonly
  terraform -chdir="envs/$env" validate
done
terraform -chdir=modules/service-accounts init -backend=false -input=false -lockfile=readonly
terraform -chdir=modules/service-accounts validate
terraform -chdir=modules/service-accounts test
python -m pip install PyYAML==6.0.2
python scripts/validate_atlantis.py
```

CI runs these checks and a static Checkov scan. The mock-provider tests create no cloud resources. Atlantis performs authenticated plans and applies; local validation does not verify GCP access or state. Never use local state for a real deployment, commit state or plan files, generate keys, or disable locking. Remote state is locked by Terraform's GCS backend; investigate the lock owner before any recovery. See [operations](docs/operations.md) and [test checklist](tests/README.md).

## Troubleshooting

- Provider installation or lock mismatch: check network access and use Terraform 1.17.2; update and review each root's lock file deliberately when changing providers.
- Backend/provider impersonation denied: verify the appropriate Atlantis runtime's impersonation grant, execution identity and bucket access in the separately managed setup. Cloning this repo grants no credentials.
- No plan: check App installation, server repo configuration, changed paths and Atlantis comments. PRO autoplan is intentionally disabled.
- Apply/update denied: inspect the plan and GCP permissions; the execution identity is intended primarily for GSA creation. Do not elevate access as a workaround.
- Locked project/state: follow the lock and failed-apply guidance in [operations](docs/operations.md); never force-unlock an active operation.
