resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.TF_SG.id]
  key_name               = "old_keypair"
  tags = {
    Name = "ExampleAppServerInstance"
  }
  user_data = var.ec2_user_data
}

output "EC2_URL" {
  value = "http://${aws_instance.app_server.public_ip}:8080"
}

