resource "aws_route53_record" "dns_record" {
    zone_id = data.aws_route53_zone.my_dns_zone.zone_id
    name    = "apps.tomarinfralab.click"
    type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cdn.domain_name
    zone_id                = aws_cloudfront_distribution.cdn.hosted_zone_id
    evaluate_target_health = true
  } 
}
