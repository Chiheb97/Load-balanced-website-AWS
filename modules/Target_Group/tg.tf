resource "aws_lb_target_group" "studocu_tg" {
  name     = var.alb_target_group_name
  port     = var.port
  protocol = var.protocol
  target_type = var.target_type
  vpc_id   = var.aws_vpc_id
  health_check {
    port = 80
  }
}


resource "aws_lb_target_group_attachment" "ec2_attachment" {
  count            = var.servers
  target_group_arn = aws_lb_target_group.studocu_tg.arn
  target_id        = var.target_ids[count.index]
}

