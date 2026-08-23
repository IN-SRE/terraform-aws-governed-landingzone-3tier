variable "cidr" {
    description = "hr-stage-vpc cidr"
    default = "10.3.0.0/16"
  
}

variable "av_zones" {
    description = "define availablity zones for hr-stage-vpc"
    default = [ "us-east-1a", "us-east-1b" ]
  
}

variable "private_subnets" {
    description = "define private subnets for hr-stage-vpc"
    default = [ "10.3.3.0/24", "10.3.4.0/24" ]
  
}

variable "private_subnets_names" {
    description = "define private subnets names for hr-stage-vpc"
    default = ["private-stage-01" , "private-stage-02"]
  
}

variable "public_subnets" {
    description = "define public subnets for hr-stage-vpc"
    default = [ "10.3.1.0/24", "10.3.2.0/24" ]
  
}

variable "public_subnets_names" {
    description = "define public subnets names for hr-stage-vpc"
    default = ["public-stage-01" , "public-stage-02"]
  
}

variable "db_subnets" {
    description = "define database subnets for hr-stage-vpc"
    default = [ "10.3.11.0/24", "10.3.12.0/24" ]
  
}

variable "db_subnets_names" {
    description = "define databse subnets names for hr-stage-vpc"
    default = ["DB-stage-01" , "DB-stage-02"]
  
}