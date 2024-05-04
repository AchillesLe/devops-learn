output "instance_ip_addr_public" {
  value = aws_eip.udemy_demo_eip.public_ip
}

output "instance_ip_addr_private" {
  value = aws_instance.udemy_demo_instance.private_ip
}
