resource "aws_alb" "alb" {
  name            = var.alb_name
  security_groups = var.sg_id
  subnets         = [var.subnet1_id, var.subnet2_id]
  tags = {
    Name = "${var.alb_name}"
  }
  
}
resource "aws_alb_listener" "listener" {
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

resource "aws_lb_listener_rule" "redirect_http_to_https" {
   listener_arn = aws_alb_listener.listener.arn
   priority     = 1
   action {
     type = "redirect"
   redirect {
       protocol = "HTTPS"
       port     = "443"
       status_code = "HTTP_301"
     }
   }

condition {
    path_pattern {
      values = var.path_pattern_values
    }
  }

  condition {
    host_header {
      values = var.host_header_values
    }
  }
}

