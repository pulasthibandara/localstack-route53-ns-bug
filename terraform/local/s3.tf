resource "aws_route53_zone" "base" {
  name = "base.cloud"
}

resource "aws_route53_zone" "api" {
  name = "api.base.cloud"
}
