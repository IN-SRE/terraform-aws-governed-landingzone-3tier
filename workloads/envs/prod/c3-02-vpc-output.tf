output "vpc_id" {
  value = module.vpc-prod.vpc_id
}

output "vpc_public_subnet_ip" {
  value = module.vpc-prod.nat_public_ips
}
output "subnet_id" {
  value = module.vpc-prod.private_subnets
}