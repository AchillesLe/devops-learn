variable "region" {
  type     = string
  nullable = false
}

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
  type        = list(string)
  nullable    = false
  description = "availabitity zones"
}

variable "private_subnets" {
  type        = list(string)
  nullable    = false
  description = "private subnets"
}

variable "public_subnets" {
  type        = list(string)
  nullable    = false
  description = "public subnets"
}
