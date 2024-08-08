terraform {
  required_providers {
    env0 = {
      source = "env0/env0"
    }
  }
}

locals {
  policy_list = flatten([
    for policy_var in var.policy_variables : {
        policy = var.${policy_var}
      }
  ])
}