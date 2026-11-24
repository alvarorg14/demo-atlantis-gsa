# Operations

## Initialization and changes

Both Atlantis GitHub Apps, server-side repository configuration, existing state buckets, VM impersonation grants and execution identities are prerequisites. The first authenticated `terraform init` for each root must use its configured GCS backend and the correct Atlantis runtime identity; backend initialization may fail if those external prerequisites are missing. Never use `-backend=false` for a real plan or apply: it is only for offline validation. Do not use workspaces to separate environments.

Add a module block in the desired root, run the README validation, and open a PR. Check the plan targets the correct project and contains only intended resources and actions. DEV/PRE autoplan is enabled; use `atlantis-nonprod plan -p dev-gsas` or `atlantis-nonprod plan -p pre-gsas` when a manual plan is needed. Apply with `atlantis-nonprod apply -p dev-gsas` or `atlantis-nonprod apply -p pre-gsas` after review. For production obtain approval first, run `atlantis-prod plan -p pro-gsas`, review, then `atlantis-prod apply -p pro-gsas`. Server-side requirements still apply. Merge only after successful pre-merge apply.

Atlantis defaults to locking a project on plan when the server does not override that setting; competing PRs for that project should wait until its lock is released. Separate projects have separate locks. The GCS backend also locks state during operations. If an apply fails, inspect Atlantis output and state, correct the PR, re-plan and review before retrying; a partially completed apply can have created resources. Do not assume failure means no change occurred.

## Drift, imports and recovery

Run an authorized Atlantis plan against a branch with the relevant project selected and inspect differences to detect drift. Do not apply a drift correction without review. Verify that the execution identity has the permissions required for the planned service-account and project IAM changes.

For a pre-existing account, first verify its project, ID and ownership and ensure it is not managed by another state. Add its module block, then use a reviewed Terraform import block in the appropriate root with the resource address `module.demo_api_dev.google_service_account.this` and import ID `projects/alvarorg14-demo-dev/serviceAccounts/demo-api-dev@alvarorg14-demo-dev.iam.gserviceaccount.com` (replace for the actual environment and account). Review the authenticated Atlantis plan to ensure it imports the intended resource and proposes no unintended changes. Apply through the normal process, then remove the temporary import block in a reviewed change. Import and refresh need sufficient existing permissions; resolve access through the platform owners rather than elevating this repository's identity.

During an Atlantis outage, stop and restore the affected instance through the separately managed setup. Do not copy state locally or bypass approvals. Any emergency access and recovery must follow the platform's separately authorized procedure; verify no run is active and re-plan afterward.

For a suspected stale state lock, identify the operation and owner from Atlantis and Terraform output, confirm it is no longer running, and coordinate with the platform operator. Only an appropriately authorized operator should use `terraform force-unlock LOCK_ID` against the correct initialized remote backend after confirming the lock is stale. Force-unlocking an active operation can corrupt state. Atlantis project locks are separate from Terraform state locks; release them through Atlantis only after coordinating with the PR owner and confirming it is safe.
