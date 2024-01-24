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
resource "aws_internet_gateway" "studocu_igw" {
  vpc_id = aws_vpc.studocu_vpc.id
   tags = {
    Name = var.igw_name
  }  
}
resource "aws_subnet" "subnet_public" {
  vpc_id = aws_vpc.studocu_vpc.id
  cidr_block = var.cidr_subnet_pub
  availability_zone = var.availability_zone1
  tags = {
    Name = var.subnet_public_name 
  }
}
resource "aws_subnet" "subnet_public2" {
  vpc_id = aws_vpc.studocu_vpc.id
  cidr_block = var.cidr_subnet_pub2
  availability_zone = var.availability_zone2
  tags = {
    Name = var.subnet_public_name2 
  }
}