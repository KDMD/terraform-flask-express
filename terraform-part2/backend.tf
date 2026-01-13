terraform {
  backend "s3" {
    bucket = "komal-terraform-state-2025"
    key    = "flask-express/ec2.tfstate"
    region = "ap-south-1"
  }
}