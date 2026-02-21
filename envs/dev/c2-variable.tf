#AWS region
variable "aws_region" {
  description = "AWS region where ec2 instance to be created"
  type = string
  default = "us-east-1"
}

# AWS instance type
variable "aws_instance_type" {
  description = "Ec2 Instance type"
  type = string
  default = "t2.micro"
}

/* # AWS instance type
variable "aws_instancetype_list" {
description = "AWS instance type"
type = list(string)
default = [ "t2.micro", "t3.micro" ]
} */

# AWS instance type
/*variable "aws_instancetype_map" {
description = "AWS instance type"
type = map (string)
default = {
  "dev" = "t2.micro"
  "prod" = "t3.micro"
}
}*/

# AWS Ec2 Key pair
variable "aws_ec2_keypair" {
description = "AWS EC2 key pair"
type = string
default = "terraform-key"
}

  variable "department" {
   
 }

variable "cidr" {
  
}

variable "private_subnets" {
  
}

variable "public_subnets" {
  
}
variable "azs" {
  
}
