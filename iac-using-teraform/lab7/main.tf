terraform {
  required_version = ">= 1.4.0"
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

module "networking" {
  source             = "./modules/networking"
  vpc_name           = var.vpc_name
  availabitity_zones = var.availabitity_zones
  cidr_block         = var.cidr_block
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
}

