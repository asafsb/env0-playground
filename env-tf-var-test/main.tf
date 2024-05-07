terraform {
  required_providers {
    }
  }

variable "bucketname" {
  type    = string
  default = "env0-acme-bucket"
}

resource "random_string" "random" {
  length  = 5
  special = false
  lower   = true
  upper   = false
  number  = true
}
  
output "s3_bucket_name" {
  value = "${var.bucketname}-${random_string.random.id}"
}
