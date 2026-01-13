# terraform-flask-express
Part 1:
Single EC2 instance deployment with running application
tf provider: aws
tfvars: mongo url, backend url
modules added: vm, vpc, igw, route, route association, sg, subnet
output: vm public ip

Executed commands:
terraform init
terraform init -reconfigure
terraform fmt
terraform validate
terraform plan -- create 7
terraform apply
