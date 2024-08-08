variable "policy_list_env" {
  type = string
}

variable "policy_list_proj" {
  type = string
}

variable "name" {
  type        = string
}

variable "action" {
  type        = string
}

variable "priority" {
  type        = string
}

variable "protocol" {
  type        = string
}

variable "src_smart_groups" {
  type        = list
}

variable "dst_smart_groups" {
  type        = list
}

variable "env0_api_key" {
  type        = string
}

variable "env0_api_secret" {
  type        = string
}
