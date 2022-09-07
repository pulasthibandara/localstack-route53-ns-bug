resource "aws_route53_zone" "base" {
  name = "base.r53x"
}

resource "aws_route53_zone" "api" {
  name = "api.base.r53x"
}

// "base" to "api"
resource "aws_route53_record" "api-ns" {
  zone_id = aws_route53_zone.base.zone_id
  name    = aws_route53_zone.api.name
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.api.name_servers
}

// "api" to "cloudfront"
resource "aws_route53_record" "route53_record" {
  zone_id = aws_route53_zone.api.zone_id
  name    = aws_route53_zone.api.name
  type    = "A"

  alias {
    name    = aws_cloudfront_distribution.s3_distribution.domain_name
    zone_id = aws_cloudfront_distribution.s3_distribution.hosted_zone_id

    //HardCoded value for CloudFront
    evaluate_target_health = false
  }
}
