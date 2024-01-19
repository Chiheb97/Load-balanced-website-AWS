resource "tls_private_key" "algo_private_key" {
  algorithm = "RSA"
}


resource "aws_key_pair" "ec2_key_pair" {
  key_name   = var.key_name
  public_key = tls_private_key.algo_private_key.public_key_openssh
  tags = {
     Name = var.key_name
  }
}