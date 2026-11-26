module "private_sg" {
    source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-security-group?ref=v2.0.0"

    name = "private-sg-asg"
    vpc_id = module.vpc-dev.vpc_id
    description = "Security group for private subnets"
    tags = local.common_tags

    ingress_rules = {
        "allow_http" = {
            ip_protocol = "tcp"
            from_port   = 80
            to_port     = 80
            referenced_security_group_id = module.alb_sg.security_group_id
        }

        "allow_https" = {
            ip_protocol = "tcp"
            from_port   = 443
            to_port     = 443
            referenced_security_group_id = module.alb_sg.security_group_id
        }
    }

    egress_rules = {
        "allow_all" = {
            ip_protocol = "-1"
            cidr_ipv4   = var.egress_private_cidr
        }
    }
}

## Public Security Group

module "public_sg" {
    source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-security-group?ref=v2.0.0"

    name = "public-sg-asg"
    vpc_id = module.vpc-dev.vpc_id
    description = "Security group for public subnets"
    tags = local.common_tags

    ingress_rules = {
        "allow_http" = {
            ip_protocol = "tcp"
            from_port   = 80
            to_port     = 80
            cidr_ipv4   = var.ingress_public_cidr
        } }

    egress_rules = {
        "allow_all" = {
            ip_protocol = "-1"
            cidr_ipv4   = var.egress_public_cidr
        }
    }
} 


    module "alb_sg" {
        source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-security-group?ref=v2.0.0"
        name = "alb-sg"
        vpc_id = module.vpc-dev.vpc_id
        description = "Security group for ALB"
        tags = local.common_tags

        ingress_rules = {
            "allow_http" = {
                ip_protocol = "tcp"
                from_port   = 80
                to_port     = 80
                cidr_ipv4   = var.ingress_public_cidr
            }

            "allow_https" = {
                ip_protocol = "tcp"
                from_port   = 443
                to_port     = 443
                cidr_ipv4   = var.ingress_public_cidr
            }
        }

        egress_rules = {
            "allow_all" = {
                ip_protocol = "-1"
                cidr_ipv4   = var.egress_public_cidr
            }
        }
    }

module "db_sg" {
    source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-security-group?ref=v2.0.0"
    name = "db-sg"
    vpc_id = module.vpc-dev.vpc_id
    description = "Security group for DB"
    tags = local.common_tags

    ingress_rules = {
        "allow_mysql_from_app" = {
            ip_protocol = "tcp"
            from_port   = 3306
            to_port     = 3306
            referenced_security_group_id = module.private_sg.security_group_id
        } }

    egress_rules = {
        "allow_all" = {
            ip_protocol = "-1"
            cidr_ipv4   = var.egress_public_cidr
        }
    }
} 