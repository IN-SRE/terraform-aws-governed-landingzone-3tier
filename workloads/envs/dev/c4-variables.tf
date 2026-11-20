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
