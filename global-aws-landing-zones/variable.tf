#AWS region
variable "aws_region" {
  description = "AWS region where ec2 instance to be created"
  type = string
  default = "us-east-1"
}



variable "log_archive" {
  description = "Email address for the AWS Organizations Log Archive account"
  validation {
    condition = can(regex(
      "^[A-Za-z0-9._%+-]+@[A-Za-z]+\\.[A-Za-z]{2,}$",
      var.log_archive_email
    ))

    error_message = "Email must be in valid format like john@gmail.com"
  }
}

 variable "audit" {
  description = "Email address for the AWS Organizations audit account"

  validation {
    condition = can(regex(
      "^[A-Za-z0-9._%+-]+@[A-Za-z]+\\.[A-Za-z]{2,}$",
      var.log_archive_email
    ))

    error_message = "Email must be in valid format like john@gmail.com"
  }

}



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
