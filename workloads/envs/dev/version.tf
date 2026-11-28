terraform {
  required_version = "~>1.13.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.20"
    }

    vault = {
      source  = "hashicorp/vault"
      version = "~>5.0"
    }
  }
  backend "s3" {

  }

}

provider "aws" {
  region = var.region

}

provider "vault" {
  address = var.vault_address
}