# devops-learn
https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-variables
https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest

# command
ssh-keygen -t rsa -b 4096 -C "your-email@gmail.com"
`enter ./keypair/udemy-key`

- terraform init
- terraform plan --var-file "terraform-dev.tfvars"
- terraform apply --var-file "terraform-dev.tfvars"
- terraform destroy --var-file "terraform-dev.tfvars"
