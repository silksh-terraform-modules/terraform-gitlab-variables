terraform {
  required_version = "~> 1.9"
  required_providers {
    gitlab = {
      source = "gitlabhq/gitlab"
      version = "17.4"
    }
  }
}

provider "gitlab" {
  # token = var.gitlab_token # better define GITLAB_TOKEN variable
  base_url = "https://gitlab.example.com/api/v4" # if you use self-hosted instance
}


module gitlab_variables {
  source = "https://github.com/silksh-terraform-modules/terraform-gitlab-variables.git"


  gitlab_project_id = 123456789
  gitlab_env_scope = "master"

  # pass json directly
  variable_specs = {"managed_by_tf": {"AWS_ACCESS_KEY_ID":{
      "variable_type": "env_var",
      "protected": false,
      "masked": false
    },"AWS_SECRET_ACCESS_KEY":{
      "variable_type": "env_var",
      "protected": false,
      "masked": false
    }},"ignored_changes":{
    "DOCKER_ENV_VARIABLES":{
      "variable_type": "file",
      "protected": false,
      "masked": false
    }}}
  variable_values = {"AWS_ACCESS_KEY_ID":"${access_key}","AWS_SECRET_ACCESS_KEY":"${secret_key}","DOCKER_ENV_VARIABLES":"VAR=abc"}
  # alternatively pass these json from file (recommended, easier to template)
#   variable_specs = jsondecode(file("file.json"))
#   variable_values = jsondecode(templatefile("file-values.json", {
#       access_key                = "a"
#       secret_key                = "b"
#   }))
}
