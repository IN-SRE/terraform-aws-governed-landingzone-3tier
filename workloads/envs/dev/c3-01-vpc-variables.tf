variable "cidr" {
    description = "hr-dev-vpc cidr"
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