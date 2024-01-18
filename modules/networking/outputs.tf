output "vpc_id" {
  value = aws_vpc.studocu_vpc.id
  sensitive = true 
}

output "subnet_private1_id" {
  value = aws_subnet.subnet_private1.id
  sensitive = true 
}
output "subnet_private2_id" {
  value = aws_subnet.subnet_private2.id
  sensitive = true 
}
