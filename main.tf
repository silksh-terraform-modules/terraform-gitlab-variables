
terraform {
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "~> 17.4"
    }
  }
}

resource "gitlab_project_variable" "this-gitlab-env-managed" {
  for_each = var.gitlab_project_id > 0 ? var.variable_specs.managed_by_tf : {}

  project   = var.gitlab_project_id
  environment_scope = var.gitlab_env_scope
  key = each.key
  value = var.variable_values[each.key]
  variable_type = each.value.variable_type
}

resource "gitlab_project_variable" "this-gitlab-env-ignored" {
  for_each = var.gitlab_project_id > 0 ? var.variable_specs.ignored_changes : {}

  project   = var.gitlab_project_id
  environment_scope = var.gitlab_env_scope
  key = each.key
  value = var.variable_values[each.key]
  variable_type = each.value.variable_type

  lifecycle {
    ignore_changes = [value]
  }
}
