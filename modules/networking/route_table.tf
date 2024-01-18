resource "aws_route_table" "rt_private" {
  vpc_id = aws_vpc.studocu_vpc.id
  tags = {
    Name =  var.rt_private
  }  
}
resource "aws_route_table_association" "rt_private1" {
  subnet_id      = aws_subnet.subnet_private1.id
  route_table_id = aws_route_table.rt_private.id
}

resource "aws_route_table_association" "rt_private2" {
  subnet_id      = aws_subnet.subnet_private2.id
  route_table_id = aws_route_table.rt_private.id
}