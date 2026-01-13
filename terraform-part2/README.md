# terraform-flask-express
Part 2:
Two EC2 instance deployment with running application
tf provider: aws
tfvars: mongo url
modules added: vm, vpc, igw, route, route association, sg, subnet
output: vm public ip, vm private ip

Executed commands:
terraform init
terraform init -reconfigure
terraform fmt
terraform validate
terraform plan -- create 9
terraform apply


The backend and frontend are deployed on separate EC2 instances within the same VPC.
Security groups restrict backend access to only the frontend EC2.
Terraform templatefile dynamically injects the backend private IP into the frontend during provisioning

