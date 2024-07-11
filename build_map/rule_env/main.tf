terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.1.0"
    }
  }
}

variable "refresh_date" {
  type = string
  default = "00/00/0000"
}

resource "random_string" "random" {
  keepers = {
      refresh_date = var.refresh_date
  }
  length           = 5
  upper            = true
  special          = false
}

provider "env0" {
  api_key    = var.env0_api_key
  api_secret = var.env0_api_secret
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
  name        = "policy_variable-set-${random_string.random.result}"
  description = "Rule policy ${var.policy_name}"
  scope       = "project"
  scope_id    = data.env0_project.project.id

  variable {
    name   = "policy_map"
    value  = join(",", [for key, value in local.policy : "${key}=${value}"])
    format = "hcl"
    type = "terraform"
  }
}

resource "env0_variable_set_assignment" "assignment" {
  scope    = "environment"
  scope_id = data.env0_environment.environment.id
  set_ids = [
    env0_variable_set.project_scope_var_set.id
  ]
}
