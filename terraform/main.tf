terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "eu-west-1"
}

resource "aws_security_group" "server_sg" {
  name        = "ConcurrencyServerSG"
  description = "Allow TLS inbound traffic"
  ingress {
    description = "Allow from public"
    from_port   = 8001
    to_port     = 8003
    protocol    = "tcp"
    cidr_blocks = [var.source_ip]
  }
  ingress {
    description = "Allow from public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.source_ip]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "ConcurrencyServerSG"
  }
}

resource "aws_spot_instance_request" "concurrency_test_server" {
  depends_on = [
    aws_security_group.server_sg
  ]
  ami                    = "ami-0d75513e7706cf2d9" # ubuntu 22.04
  spot_price             = "0.50"
  instance_type          = "c5.xlarge"
  spot_type              = "one-time"
  wait_for_fulfillment   = "true"
  key_name               = var.keyname
  user_data = "${file("install_server.sh")}"
  vpc_security_group_ids = [aws_security_group.server_sg.id]

  tags = {
    Name = "ConcurrencyTestServer"
  }
}

output "concurrency_test_server_ips" {
  value = ["${aws_spot_instance_request.concurrency_test_server.public_ip}"]
}
