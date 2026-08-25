output "vpc_id" {
  value = module.vpc-stage.vpc_id
}

output "vpc_public_subnet_ip" {
  value = module.vpc-stage.nat_public_ips
}
output "subnet_id" {
  value = module.vpc-stage.private_subnets
}