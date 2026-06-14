   # Terraform Block
   terraform {
  required_version = "~>1.13.5"
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>6.20"
      
    }
  }
   backend "s3" {
   # DO NOT put any values here. 
  }
    
  }
  
  # Provider Block

  provider "aws" {
    region = var.aws_region
    
  }
 