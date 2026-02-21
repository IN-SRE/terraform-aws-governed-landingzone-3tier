module "vpc-project1" {
    source = "terraform-aws-modules/vpc/aws"
    version = "6.6.0"
    
    name = "${local.name}-vpc"
    
    cidr = "10.0.0.0/16"
    private_subnets = ["10.0.1.0/24"]
    public_subnets = ["10.0.2.0/24"]
    azs = ["us-east-1a"]
    
    enable_dns_hostnames = true
    enable_dns_support = true
    single_nat_gateway = true
    
  
}