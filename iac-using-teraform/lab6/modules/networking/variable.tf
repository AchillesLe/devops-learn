variable "region" {
  type = string
}

variable "availability_zone_1" {
  type        = string
  description = "Availability zone 1"
}

variable "availability_zone_2" {
  type        = string
  description = "Availability zone 2"
}

variable "cidr_block" {
  type     = string
  nullable = false
}

variable "public_subnet_ips" {
  type     = list(string)
  nullable = false
}

variable "private_subnet_ips" {
  type     = list(string)
  nullable = false
}
