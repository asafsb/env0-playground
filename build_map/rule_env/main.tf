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
    name = var.name
    action = var.action
    protocol = var.protocol
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

resource "env0_configuration_variable" "json_variable" {
  name   = "policy-${var.name}-${random_string.random.result}"
  type   = "terraform"
  value  = jsonencode(local.policy)
  format = "JSON"
  environment_id = data.env0_environment.environment.id
}