# Validation checklist

Credential-free CI checks formatting, initialization without backends, validation of all roots and module, mock-provider module tests, Atlantis YAML structure and static Terraform security scanning. These do not prove deployed IAM, Atlantis server configuration or remote backend access.

Perform the following in a controlled integration environment with authorized operators, without deleting setup infrastructure. Record results in the PR; they are pending until exercised:

- [ ] Initialize each existing remote GCS backend and confirm each successful apply updates only the intended state.
- [ ] Create one GSA through Atlantis; add a second and check its plan contains exactly one addition.
- [ ] DEV and PRE changes independently trigger only their matching NoPRO projects; a shared module change triggers both.
- [ ] PRO requires approval before planning and uses the approved, mergeable, undiverged apply workflow.
- [ ] A user without impersonation permission cannot apply; PRO cannot create in DEV or access DEV/PRE state.
- [ ] Verify the runner can grant and remove an approved project role and cannot create a bucket or service-account keys unless explicitly authorized.
- [ ] In a controlled environment, create and delete a disposable GSA and verify its managed grants are removed.
- [ ] Two PRs planning the same project encounter Atlantis locking; verify safe lock release.
- [ ] Server-side OPA policy tests are pending until platform-controlled OPA integration exists.
