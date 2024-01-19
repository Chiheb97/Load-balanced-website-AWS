output "private_key" {
  value = tls_private_key.algo_private_key.private_key_pem
  sensitive = true 
  }
  
output "public_key_name" {
  value = aws_key_pair.ec2_key_pair.key_name
  }

output "public_key" {
  value = aws_key_pair.ec2_key_pair.public_key
  sensitive = true 
  }
output "private_ip_addresses" {
  value = aws_instance.vm_instance[*].private_ip
}

output "instance_ids" {
  value = aws_instance.vm_instance[*].id
}