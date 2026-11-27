# ACM Module - To create and Verify SSL Certificates
 module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "6.3.0"

  domain_name  = trimsuffix(data.aws_route53_zone.my_dns_zone.name, ".")
  zone_id      = data.aws_route53_zone.my_dns_zone.zone_id

  subject_alternative_names = [
    "*.tomarinfralab.click"
  ]
  tags = local.common_tags

  # Validation Method
  validation_method = "DNS"
  wait_for_validation = true  
 }



# Output ACM Certificate ARN
output "acm_certificate_arn" {
  description = "The ARN of the certificate"
  value       = module.acm.acm_certificate_arn
}