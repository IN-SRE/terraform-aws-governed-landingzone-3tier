output "vpc_id" {
  value = module.vpc-dev.vpc_id
}

output "vpc_public_subnet_ip" {
  value = module.vpc-dev.nat_public_ips
}
output "subnet_id" {
  value = module.vpc-dev.private_subnets
}


output "dns_zoneid" {
    value = data.aws_route53_zone.my_dns_zone.zone_id
  
}

output "domainname" {
    value = data.aws_route53_zone.my_dns_zone.name
  
}