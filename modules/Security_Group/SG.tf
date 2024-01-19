resource "aws_security_group" "studocu_sg" {
  name        = var.sg_name
  description = var.description
  vpc_id      = var.vpc_id
  tags = {
     Name = var.sg_name
  }
  ingress {
     from_port =var.from_port
     to_port = var.to_port
     protocol = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}