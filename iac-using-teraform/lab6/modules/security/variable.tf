variable "region" {
  type = string
  default = "ap-southeast-1"
}

variable "vcp_id" {
  type = string
  description = "The VPC ID"
  nullable = false
}