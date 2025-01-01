terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "vue_app_bucket" {
  bucket = "vue3-app-bucket"
  acl    = "private"

  tags = {
    Name        = "Vue3AppBucket"
    Environment = "Development"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.vue_app_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.vue_app_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name = "VueAppOAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                 = "always"
  signing_protocol                 = "sigv4"
}

resource "aws_cloudfront_distribution" "vue_app_distribution" {
  enabled = true

  origin {
    domain_name = aws_s3_bucket.vue_app_bucket.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.vue_app_bucket.id

    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.vue_app_bucket.id

    viewer_protocol_policy = "redirect-to-https"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  tags = {
    Name        = "Vue3AppDistribution"
    Environment = "Development"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.vue_app_bucket.bucket
}

output "cloudfront_domain_name" {
  value = aws_cloudfront_distribution.vue_app_distribution.domain_name
}
