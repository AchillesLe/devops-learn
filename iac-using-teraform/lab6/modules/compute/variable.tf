variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "image_id" {
  type        = string
  description = "The id of the machine image (AMI) to use for the server"
}

variable "instance_type" {
  type        = string
  description = "Type of EC2 instance to launch. Ex: t2.micro"
  default     = "t3.micro"
}

variable "key_name" {
  type    = string
  nullable    = false
}

variable "ec2_security_group_ids" {
  type    = list(any)
  default = []
}

variable "subnet_id" {
  type        = string
  nullable    = false
  description = "The subnet ID to launch in"
}
