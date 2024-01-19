data "aws_route53_zone" "existing_zone" {
  name         = var.domain_name
}
data "aws_acm_certificate" "acm" {
  domain   = "*.code.studucu.com"
}
resource "aws_route53_record" "cname_route53_record" {
  zone_id = data.aws_route53_zone.existing_zone.zone_id 
  name    = var.sub_domain_name 
  type    = var.type
  ttl     = var.ttl
  records = [var.record_name]
}
# DNS Registration 

module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 2.0"

  domain_name = trimsuffix(data.aws_route53_zone.existing_zone.name, ".") 
  zone_id     = data.aws_route53_zone.existing_zone.id
  subject_alternative_names = [
    "*.code.studucu.com"
  ]
}