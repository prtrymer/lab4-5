# Configure the AWS Provider
provider "aws" {
  region = "eu-west-2"
}

# Use S3 as a backend for state storage
# You'll need to create this S3 bucket first
terraform {
  backend "s3" {
    bucket = "chaika-terraform-state"  # Replace with your S3 bucket name
    key    = "lab4-5/terraform.tfstate"
    region = "eu-west-2"
  }
}

# Reference the existing security group
data "aws_security_group" "web_server" {
  id = "sg-0f6025c2ca1b3f3a4"
}

# Reference the existing EC2 instance
data "aws_instance" "web_server" {
  instance_id = "i-080ba1ba46c2c94ce"  # Replace with your actual instance ID
}

# Output the public IP of the instance
output "public_ip" {
  value = data.aws_instance.web_server.public_ip
}

# Output the security group name
output "security_group_name" {
  value = data.aws_security_group.web_server.name
}

# Output the instance state
output "instance_state" {
  value = data.aws_instance.web_server.instance_state
}