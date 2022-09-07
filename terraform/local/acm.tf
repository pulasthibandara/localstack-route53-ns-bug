module "api_certificate" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 3.0"

  domain_name = aws_route53_zone.api.name
  zone_id     = aws_route53_zone.api.id

  wait_for_validation = true
}
