variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
}

data "aws_ami" "ami_id" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
  # region = var.region
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Instance Name"
  type        = string
  default     = "Jenkins Instance"
}

variable "key_pair" {
  description = "Key Pair"
  type        = string
  default     = "keypair"
}

variable "ec2_user_data" {
  description = "User data script for EC2"
  type        = string
  default     = <<EOF
  #!/bin/bash
  # Install Jenkins and Java 
  sudo wget -O /etc/yum.repos.d/jenkins.repo \
      https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo wget -O /etc/yum.repos.d/jenkins.repo \
      https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  sudo yum -y upgrade
  # Add required dependencies for the jenkins package
  sudo amazon-linux-extras install -y java-openjdk11 
  sudo yum install -y jenkins
  sudo systemctl daemon-reload
  
  # Start Jenkins
  sudo systemctl enable jenkins
  sudo systemctl start jenkins
  EOF
}