resource "aws_alb" "alb" {
  name            = var.alb_name
  security_groups = var.sg_id
  internal           = false
  subnets         = [var.subnet1_id, var.subnet2_id]
  tags = {
    Name = "${var.alb_name}"
  }

}
resource "aws_alb_listener" "listener_https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = var.listener_port
  protocol          = var.protocol
  ssl_policy        = var.protocol == "HTTPS" ? "ELBSecurityPolicy-2016-08" : null
  certificate_arn   = var.protocol == "HTTPS" ? var.certificate_arn : null

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    target_group_arn = var.target_group_arn
    type             = "forward"
  }
}

