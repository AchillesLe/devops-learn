# devops-learn
- export AWS_DEFAULT_REGION="ap-southeast-1"
- export AWS_ACCESS_KEY_ID=AKIA4MTWJDKZUPO43HLP
- export AWS_SECRET_ACCESS_KEY=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

# command
- terraform init
- terraform plan --var-file "terraform-dev.tfvars"
- terraform apply --var-file "terraform-dev.tfvars"
- terraform destroy --var-file "terraform-dev.tfvars"