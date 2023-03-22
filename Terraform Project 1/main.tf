terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "Jenkins_server" {
  # ami                    = var.ami_id
  ami                    = data.aws_ami.ami_id.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  key_name               = var.key_pair
  tags = {
    Name = var.instance_name
  }
  user_data = var.ec2_user_data
}

output "Jenkins_URL" {
  value = "http://${aws_instance.Jenkins_server.public_ip}:8080"
}

resource "aws_security_group" "TF_SG" {
  name        = "TF_SG"
  description = "Allow inbound traffic"
  tags = {
    Name = "MySecurityGroup"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_s3_bucket" "jenkins_bucket" {
  bucket = "jenkins-bucket-34897s5t"
  tags = {
    Name = "Jenkins"
  }
}

resource "aws_s3_bucket_acl" "jenkins_bucket_acl" {
  bucket = aws_s3_bucket.jenkins_bucket.id
  acl    = "private"
}