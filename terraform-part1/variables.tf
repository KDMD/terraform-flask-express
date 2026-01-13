variable "aws_region" {
  default = "ap-south-1"
}


variable "instance_type" {
  default = "t3.micro"
}


variable "ubuntu_ami_id" {
  description = "Ubuntu 22.04 LTS AMI ID"
  type        = string
  default     = "ami-02b8269d5e85954ef"  # Put a valid AMI ID here
}


variable "mongo_url" {
  description = "MongoDB connection string"
  sensitive   = true
}


variable "backend_url" {
  description = "Backend URL for Express"
  default     = "http://localhost:5000"
}


variable "key_name" {
  description = "EC2 Key Pair name"
}