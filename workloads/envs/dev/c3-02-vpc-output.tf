output "vpc_id" {
  value = module.vpc-dev.vpc_id
}

output "vpc_public_subnet_ip" {
  value = module.vpc-dev.nat_public_ips
}
output "subnet_id" {
  value = module.vpc-dev.private_subnets
}