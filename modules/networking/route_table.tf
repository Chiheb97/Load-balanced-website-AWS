resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.studocu_vpc.id
  tags = {
    Name =  var.rt_private
  }  
}
resource "aws_route" "studocu_route_public" {
  route_table_id = aws_route_table.rt_private.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.studocu_igw.id
}
resource "aws_route_table_association" "rt_private1" {
  subnet_id      = aws_subnet.subnet_private1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_private2" {
  subnet_id      = aws_subnet.subnet_private2.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt_public1" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.rt_private.id
}
resource "aws_route_table_association" "rt_public2" {
  subnet_id      = aws_subnet.subnet_public2.id
  route_table_id = aws_route_table.rt_private.id
}