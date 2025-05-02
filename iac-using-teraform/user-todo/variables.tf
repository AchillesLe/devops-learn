variable "region" {
  description = "AWS Region"
  type        = string
  default     = "ap-southeast-1"
}

variable "docker_image" {
  description = "Docker image to use from Docker Hub"
  type        = string
  default     = "Yuri7030/user-todo:v1"
}

variable "docker_hub_username" {
  description = "Docker Hub username"
  type        = string
  default     = "Yuri7030"
}

variable "docker_hub_password" {
  description = "Docker Hub password"
  type        = string
  # sensitive   = true
  default = "Yuriboyka@7030"
}
