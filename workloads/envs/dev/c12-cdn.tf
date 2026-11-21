resource "aws_cloudfront_distribution" "cdn" {
  enabled         = var.cdn_enabled
  is_ipv6_enabled = var.cdn_is_ipv6_enabled
  aliases         = var.cdn_aliases

  origin {
    domain_name = module.alb.alb_dns_name
    origin_id   = var.cdn_origin_id

    custom_origin_config {
      http_port              = var.cdn_origin_http_port
      https_port             = var.cdn_origin_https_port
      origin_protocol_policy = var.cdn_origin_protocol_policy
      origin_ssl_protocols   = var.cdn_origin_ssl_protocols
    }
  }

  default_cache_behavior {
    target_origin_id        = var.cdn_origin_id
    viewer_protocol_policy  = var.cdn_viewer_protocol_policy

    allowed_methods = var.cdn_allowed_methods
    cached_methods  = var.cdn_cached_methods

    cache_policy_id = var.cdn_cache_policy_id
  }

  restrictions {
    geo_restriction {
      restriction_type = var.cdn_geo_restriction_type
    }
  }

  viewer_certificate {
    acm_certificate_arn      = module.acm.acm_certificate_arn
    ssl_support_method       = var.cdn_ssl_support_method
    minimum_protocol_version = var.cdn_minimum_protocol_version
  }
}
