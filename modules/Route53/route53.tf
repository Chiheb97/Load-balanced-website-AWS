data "aws_route53_zone" "existing_zone" {
  name         = var.domain_name
}

resource "null_resource" "wait_for_acm_validation" {
  provisioner "local-exec" {
    command = <<-EOF
      while [ "$(aws acm describe-certificate --certificate-arn ${aws_acm_certificate.acm_cert.arn} --query 'Certificate.Status' --output text)" != "ISSUED" ]; do
        sleep 10
      done
    EOF
  }

  depends_on = [aws_acm_certificate.acm_cert]
  }
resource "aws_acm_certificate" "acm_cert" {
  domain_name       = "${var.subdomain}.${var.domain_name}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "chiheb" {
  for_each = {
    for dvo in aws_acm_certificate.acm_cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }
  allow_overwrite = true
  name            = each.value.name
  records         = [var.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.existing_zone.id
}
resource "aws_acm_certificate_validation" "example" {
  certificate_arn         = aws_acm_certificate.acm_cert.arn
  validation_record_fqdns = [for record in aws_route53_record.chiheb : record.fqdn]
}




