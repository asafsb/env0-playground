terraform {
  backend "s3" {
    bucket = "asaf-state-bucket"
    key    = "statemigtest"
    region = "us-west-2"
  }
  required_providers {
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

variable "string_length" {
  type = string
  default = 5
}

resource "random_string" "random" {
  keepers = {
      refresh_date = var.refresh_date
  }
  length           = var.string_length
  upper            = true
  special          = false
}

output "random_string" {
    value = random_string.random.result
}
