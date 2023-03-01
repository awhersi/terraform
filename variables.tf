variable "ami_id" {
  description = "AMI ID"
  type        = string
  default     = "ami-0dfcb1ef8550277af"
}

variable "instance_type" {
  description = "Instance Type"
  type        = string
  default     = "t2.micro"
}

variable "region" {
  description = "Region"
  type        = string
  default     = "us-east-1"
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