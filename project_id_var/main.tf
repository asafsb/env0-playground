resource "null_resource" "example" {
}

variable "project_id_var" {
  type = string
}

output "project_id" {
  value = var.project_id_var
}
