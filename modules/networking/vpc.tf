resource "aws_vpc" "studocu_vpc" {
    cidr_block = var.cidr_block
    tags = {
      Name = var.vpc_name
    }
  
}