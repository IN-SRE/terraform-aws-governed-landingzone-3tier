variable "cidr" {
    description = "hr-prod-vpc cidr"
    default = "10.2.0.0/16"
  
}

variable "av_zones" {
    description = "define availablity zones for hr-dev-vpc"
    default = [ "us-east-1a", "us-east-1b" ]
  
}

variable "private_subnets" {
    description = "define private subnets for hr-prod-vpc"
    default = [ "10.2.3.0/24", "10.2.4.0/24" ]
  
}

variable "private_subnets_names" {
    description = "define private subnets names for hr-prod-vpc"
    default = ["private-prod-01" , "private-prod-02"]
  
}

variable "public_subnets" {
    description = "define public subnets for hr-prod-vpc"
    default = [ "10.2.1.0/24", "10.2.2.0/24" ]
  
}

variable "public_subnets_names" {
    description = "define public subnets names for hr-prod-vpc"
    default = ["public-prod-01" , "public-prod-02"]
  
}

variable "db_subnets" {
    description = "define database subnets for hr-prod-vpc"
    default = [ "10.2.11.0/24", "10.2.12.0/24" ]
  
}

variable "db_subnets_names" {
    description = "define databse subnets names for hr-prod-vpc"
    default = ["DB-prod-01" , "DB-prod-02"]
  
}