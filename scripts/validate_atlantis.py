"""Check the repository's expected Atlantis YAML structure and isolation."""
from pathlib import Path

import yaml


def validate(path, expected, autoplan):
    data = yaml.safe_load(Path(path).read_text())
    assert set(data) == {"version", "autodiscover", "projects"}, path
    assert data["version"] == 3 and data["autodiscover"] == {"mode": "disabled"}, path
    projects = data["projects"]
    assert len(projects) == len(expected), path
    assert {project["name"] for project in projects} == set(expected), path
    for project in projects:
        assert set(project) == {"name", "dir", "workspace", "terraform_version", "repo_locks", "autoplan"}, project
        assert project["dir"] == expected[project["name"]], project
        assert project["workspace"] == "default" and project["terraform_version"] == "v1.17.2", project
        assert project["repo_locks"] == {"mode": "on_plan"}, project
        assert project["autoplan"]["enabled"] is autoplan, project
        if autoplan:
            assert set(project["autoplan"]) == {"enabled", "when_modified"}, project
            assert set(project["autoplan"]["when_modified"]) == {
                "*.tf", ".terraform.lock.hcl", "../../modules/service-accounts/**/*.tf", "../../atlantis-nonprod.yaml"
            }, project
        else:
            assert set(project["autoplan"]) == {"enabled"}, project


validate("atlantis-nonprod.yaml", {"dev-gsas": "envs/dev", "pre-gsas": "envs/pre"}, True)
validate("atlantis-prod.yaml", {"pro-gsas": "envs/pro"}, False)
print("Atlantis YAML structure and project settings are valid")
