variable "region" {
    description = "this is aws region for HR-dev-VPC" 
    default = "us-east-1"
}

variable "department" {
    description = "project3 department name"
    default = "HR"
  
}

variable "environment" {
    description = "define enviornment for resource"
    default = "Dev"
  
}

variable "cidr" {
    description = "vpc-cidr"
    default = "10.1.0.0/16"
  
}

variable "av_zones" {
    description = "define availablity zones for hr-dev-vpc"
    default = [ "us-east-1a", "us-east-1b" ]
  
}

variable "private_subnets" {
    description = "define private subnets for hr-dev-vpc"
    default = [ "10.1.3.0/24", "10.1.4.0/24" ]
  
}

variable "private_subnets_names" {
    description = "define private subnets names for hr-dev-vpc"
    default = ["private-01" , "private-02"]
  
}

variable "public_subnets" {
    description = "define public subnets for hr-dev-vpc"
    default = [ "10.1.1.0/24", "10.1.2.0/24" ]
  
}

variable "public_subnets_names" {
    description = "define public subnets names for hr-dev-vpc"
    default = ["public-01" , "public-02"]
  
}

variable "db_subnets" {
    description = "define database subnets for hr-dev-vpc"
    default = [ "10.1.11.0/24", "10.1.12.0/24" ]
  
}

variable "db_subnets_names" {
    description = "define databse subnets names for hr-dev-vpc"
    default = ["DB-01" , "DB-02"]
  
}

####### asg variables ######

variable "instance_type" {
    description = "define instance type for hr-dev-vpc"
    default = "t3.micro"
}

variable "key_name" {
  description = "Name of the key pair to use for EC2 instances"
  default     = "workload-us-ec2-key"
}


####### security group variables ######

variable "private_sg_name" {
    description = "it is private security group name"
    default = "Private-sg"
    }
  
variable "public_sg_name" {
    description = "it is public security group name"
    default = "Public-sg"
    }
  
  variable "ingress_private_cidr" {
    description = "it is for private cidr block for ingress rule"
    default = "0.0.0.0/0"
  }

  variable "egress_private_cidr" {
    description = "it is for private cidr block for egress rule"
    default = "0.0.0.0/0"
  }

 

  variable "ingress_public_cidr" {
    description = "it is for public cidr block for ingress rule"
    default = "0.0.0.0/0"
  }

  variable "egress_public_cidr" {
    description = "it is for public cidr block for egress rule"
    default = "0.0.0.0/0"
  }


  variable "egress_db_cidr" {
    description = "it is for database cidr block for egress rule"
    default = "0.0.0.0/0"
  }



####### CDN ######

variable "cdn_enabled" {
  description = "Enable CloudFront distribution"
  type        = bool
  default     = true
}

variable "cdn_is_ipv6_enabled" {
  description = "Enable IPv6 for CloudFront"
  type        = bool
  default     = true
}

variable "cdn_aliases" {
  description = "CloudFront alternate domain names"
  type        = list(string)
  default     = ["app.tomarinfralab.click"]
}

variable "cdn_origin_id" {
  description = "CloudFront origin identifier"
  type        = string
  default     = "dev-alb-origin"
}

variable "cdn_origin_http_port" {
  description = "Origin HTTP port"
  type        = number
  default     = 80
}

variable "cdn_origin_https_port" {
  description = "Origin HTTPS port"
  type        = number
  default     = 443
}

variable "cdn_origin_protocol_policy" {
  description = "Origin protocol policy"
  type        = string
  default     = "https-only"
}

variable "cdn_origin_ssl_protocols" {
  description = "Supported SSL protocols for origin"
  type        = list(string)
  default     = ["TLSv1.2"]
}

variable "cdn_viewer_protocol_policy" {
  description = "Viewer protocol policy"
  type        = string
  default     = "redirect-to-https"
}

variable "cdn_allowed_methods" {
  description = "Allowed HTTP methods"
  type        = list(string)
  default     = [
    "GET",
    "HEAD",
    "OPTIONS",
    "PUT",
    "POST",
    "PATCH",
    "DELETE"
  ]
}

variable "cdn_cached_methods" {
  description = "Cached HTTP methods"
  type        = list(string)
  default     = ["GET", "HEAD"]
}

variable "cdn_cache_policy_id" {
  description = "CloudFront caching disabled policy ID"
  type        = string
  default     = "4135ea2d-6df8-44a3-9df3-4b5a84be39ad"
}

variable "cdn_geo_restriction_type" {
  description = "Geo restriction type"
  type        = string
  default     = "none"
}

variable "cdn_ssl_support_method" {
  description = "SSL certificate support method"
  type        = string
  default     = "sni-only"
}

variable "cdn_minimum_protocol_version" {
  description = "Minimum TLS protocol version"
  type        = string
  default     = "TLSv1.2_2021"
}

##### Vault variables ######
variable "vault_address" {
  description = "HashiCorp Vault URL"
  type        = string
  default     = "http://localhost:8200"
}


variable "app_role_name" {
  description = "IAM role used by application EC2"
  type        = string
  default     = "rdsdb-role"
}