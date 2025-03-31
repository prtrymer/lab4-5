provider "aws" {
  region = "eu-west-2"
}

resource "aws_security_group" "web_server" {
  name        = "launch-wizard-1"
  # Match exactly the existing description to prevent replacement
  description = "launch-wizard-1 created 2025-03-04T18:21:16.847Z"

  # Don't define specific ingress/egress rules, use lifecycle to ignore them
  lifecycle {
    ignore_changes = [
      description,
      ingress,
      egress,
      tags,
      tags_all
    ]
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0d18e50ca22537278"
  instance_type          = "t2.micro"
  # Use the existing security group ID directly to avoid any changes
  vpc_security_group_ids = ["sg-0f6025c2ca1b3f3a4"]

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      ami,
      user_data,
      associate_public_ip_address,
      vpc_security_group_ids,
      tags,
      tags_all
    ]
  }
}

output "public_ip" {
  value = aws_instance.web_server.public_ip
}