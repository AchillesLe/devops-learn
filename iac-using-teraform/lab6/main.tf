provider "aws" {
  region = var.region
}

module "networking" {
  source              = "./modules/networking"
  region              = var.region
  availability_zone_1 = var.availability_zone_1
  availability_zone_2 = var.availability_zone_2
  cidr_block          = var.cidr_block
  public_subnet_ips   = var.public_subnet_ips
  private_subnet_ips  = var.private_subnet_ips
}

module "security" {
  source = "./modules/security"
  region = var.region
  vcp_id = module.networking.vpc_id
}

resource "aws_key_pair" "udemy-keypair" {
  key_name   = "udemy-keypair"
  public_key = file("./keypair/udemy-key.pub")
}

module "compute" {
  source                 = "./modules/compute"
  region                 = var.region
  key_name               = aws_key_pair.udemy-keypair.key_name
  image_id               = var.amis[var.region]
  instance_type          = var.instance_type
  ec2_security_group_ids = [module.security.public_security_group_id]
  subnet_id              = module.networking.public_subnet_ids[0]
}
