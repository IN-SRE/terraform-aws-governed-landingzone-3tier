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
    bucket       = "terraform-on-aws-for-ec2-inder"
    key          =  "pipeline-test/prod/terraform.tfstate"
    use_lockfile = true
    region       = "us-east-1"
  }
    
  }
  
  # Provider Block

  provider "aws" {
    region = var.aws_region
    
  }
 