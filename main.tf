
provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket = "chaika-terraform-state" 
    key    = "lab4-5/terraform.tfstate"
    region = "eu-west-2"
  }
}

data "aws_security_group" "web_server" {
  id = "sg-0f6025c2ca1b3f3a4"
}

data "aws_instance" "web_server" {
  instance_id = "i-080ba1ba46c2c94ce" 
}

output "public_ip" {
  value = data.aws_instance.web_server.public_ip
}

output "security_group_name" {
  value = data.aws_security_group.web_server.name
}

output "instance_state" {
  value = data.aws_instance.web_server.instance_state
}