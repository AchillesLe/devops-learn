variable "region" {
  type    = string
  default = "value"
}

variable "image_id" {
  type        = string
  description = "Image id"
}

variable "instance_type" {
  type        = string
  description = "instance type"
}

variable "amis" {
  type = map(any)
  default = {
    "ap-southeast-1" : "ami-05b46bc4327cf9d99"
    "ap-northeast-1" : "ami-0ab3794db9457b60a"
  }
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
