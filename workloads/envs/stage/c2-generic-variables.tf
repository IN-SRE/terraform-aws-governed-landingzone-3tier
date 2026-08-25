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
    default = "stage"
  
}