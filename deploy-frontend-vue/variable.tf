variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "ap-southeast-1"
}

variable "bucket_name" {
    description = "The name of the S3 bucket"
    type        = string
    default     = "my-frontend-bucket"
}
