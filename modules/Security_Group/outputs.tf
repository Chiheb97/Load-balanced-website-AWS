output "sg_id_ec2" {
  value = aws_security_group.allow_ec2.id
  sensitive = true
}
output "alb_sg"{
  value = aws_security_group.allow_alb.id
}