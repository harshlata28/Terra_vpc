provider "aws" {
  access_key = "AKIAYGTU2AWTYUFATM7D"
  secret_key = "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"
  region     = "ap-south-1"
}

resource "aws_instance" "Ec2" {
  ami     = "ami-00bf4ae5a7909786c"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.Terra_security_group.name]
  key_name        = "Terra-vpc"

  tags = {

    Name = "Ec2"
  }
}

resource "aws_default_vpc" "Terra_vpc" {
  tags = {
    Name = "Terra_vpc"
  }
}

resource "aws_security_group" "Terra_security_group" {
  name        = "Terra_security_group"
  description = "creating scerity group for vpc"
  vpc_id      = aws_default_vpc.Terra_vpc.id


  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.Terra_vpc.cidr_block]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.Terra_vpc.cidr_block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_default_vpc.Terra_vpc.cidr_block]
  }

  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {

    Name = "Terra_security_group"
  }
}

