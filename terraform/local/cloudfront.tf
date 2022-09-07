resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.api-bucket.bucket_domain_name
    origin_id   = "s3-cloudfront-asset"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.origin_access_identity_asset.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = [var.domain_name]

  default_cache_behavior {
    allowed_methods = [
      "GET",
      "HEAD",
      "OPTIONS"
    ]

    cached_methods = [
      "GET",
      "HEAD",
    ]

    target_origin_id         = "s3-cloudfront-asset"
    viewer_protocol_policy   = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  // viewer_certificate {
  //   cloudfront_default_certificate = true
  //   acm_certificate_arn            = var.domain_acm_cert_arn
  //   ssl_support_method             = "sni-only"
  //   minimum_protocol_version       = "TLSv1"
  // }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/"
  }

  wait_for_deployment = false
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity_asset" {
  comment = "access-identity-${local.bucket_name}.s3.amazonaws.com"
}
