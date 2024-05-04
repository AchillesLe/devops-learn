# devops-learn
https://developer.hashicorp.com/terraform/tutorials/oci-get-started/oci-variables
# command
ssh-keygen -t rsa -b 4096 -C "your-email@gmail.com"
#enter ./keypair/udemy-key

terraform plan --var-file "terraform-dev.tfvars"
terraform apply --var-file "terraform-dev.tfvars"
terraform destroy --var-file "terraform-dev.tfvars"