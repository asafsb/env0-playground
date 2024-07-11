terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

provider "env0" {
}

locals {
  policy = {
    name = var.policy_name
    action = var.policy_action
    protocol = var.policy_protocol
  }
}

output "test" {
  value = local.policy
}

data "env0_project" "project" {
  id = var.policy_list_proj
}

data "env0_environment" "environment" {
  id = var.policy_list_env
}


resource "env0_variable_set" "project_scope_var_set" {
  name        = "policy_variable-set"
  description = "Rule policy ${var.policy_name}"
  scope       = "project"
  scope_id    = data.env0_project.project.id

  variable {
    name   = "policy_map"
    value  = local.policy
    format = "hcl"
    type = "terraform"
  }
}

resource "env0_variable_set_assignment" "assignment" {
  scope    = "environment"
  scope_id = data.env0_environment.id
  set_ids = [
    env0_variable_set.project_scope_example.id
  ]
}
