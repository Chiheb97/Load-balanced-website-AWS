output "sg_id" {
  value = aws_security_group.studocu_sg.id
  sensitive = true
}
