variable "gitlab_project_id" {
  default = 0
  type = number
  description = "first project on gitlab have id = 1 so 0 = not create"
}

variable "gitlab_env_scope" {
  default = "*"
}

variable "variable_specs" {
   description = "variables specification, best pass from file eg jsondecode(file(templates/gitlab/gitlab-specs.json)"
   default = {"managed_by_tf":{},"ignored_changes":{}}
}

variable "variable_values" {
  description = "variable values"
  default= []
}
