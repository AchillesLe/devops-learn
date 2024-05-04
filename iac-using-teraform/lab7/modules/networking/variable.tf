variable "vpc_name" {
  type        = string
  description = "VPC name"
  nullable    = false
}

variable "cidr_block" {
  type     = string
  nullable = false
}

variable "availabitity_zones" {
  type     = list(string)
  nullable = false
}

variable "private_subnets" {
  type     = list(string)
  nullable = false
}

variable "public_subnets" {
  type     = list(string)
  nullable = false
}
