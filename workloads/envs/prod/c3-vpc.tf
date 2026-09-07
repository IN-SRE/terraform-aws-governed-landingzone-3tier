module "vpc-prod" {
  source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//vpc?ref=v1.0.3"
   
    name = "${local.name}-vpc"
    cidr = var.cidr
    azs = var.av_zones
    
    #public and private subnets
    public_subnets = var.public_subnets
    public_subnet_names = var.public_subnets_names

    private_subnets = var.private_subnets
    private_subnet_names = var.private_subnets_names

    # Nat and IGW
    enable_nat_gateway = true
    single_nat_gateway = true

    #database subnets and route table
    database_subnets = var.db_subnets
    create_database_subnet_route_table = true
    create_database_subnet_group = true 
    database_subnet_group_name = "DB-Group-${local.name}"
    

    #dns enable
    enable_dns_hostnames = true
    enable_dns_support = true
    
    #tags
    tags = local.common_tags
    
}
   