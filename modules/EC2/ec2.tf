resource "aws_instance" "vm_instance" {
  count         = var.instance_count
  ami           = var.ami
  instance_type = var.instance_type
 
  user_data     = file(var.filename)
  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
  disable_api_termination = var.disable_api_termination
 
  ebs_block_device {
    device_name = "/dev/xvda"
    volume_size = var.volume_size
  }
  # Add a security group
  key_name                    = var.key_name
  vpc_security_group_ids      = ["${var.sg_id}"]
  subnet_id                   =  element(var.subnet_ids, count.index)
}
