resource "aws_subnet" "subnet_private1" {
  vpc_id = aws_vpc.studocu_vpc.id
  cidr_block = var.cidr_subnet1
  availability_zone = var.availability_zone1
  tags = {
    Name = var.subnet_private1 
  }
}
resource "aws_subnet" "subnet_private2" {
  vpc_id = aws_vpc.studocu_vpc.id
  cidr_block = var.cidr_subnet2
  availability_zone = var.availability_zone2
  tags = {
    Name = var.subnet_private2
  }
}