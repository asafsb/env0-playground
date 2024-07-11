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
