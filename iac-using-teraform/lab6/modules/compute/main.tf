provider "aws" {
  region = var.region
}

resource "aws_instance" "udemy_demo_instance" {
  ami           = var.image_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id
  tags = {
    Name = "Udemy demo EC2 instance"
  }
  vpc_security_group_ids = var.ec2_security_group_ids
}

resource "aws_eip" "udemy_demo_eip" {
  instance = aws_instance.udemy_demo_instance.id
  tags = {
    Name = "Udemy demo EIP for EC2"
  }
}
