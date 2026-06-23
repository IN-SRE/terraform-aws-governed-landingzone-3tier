locals {
  department = var.department
  environment = "dev"
  name = "${var.department}-${local.environment}"

  common_tag = {
    Department      = local.department
    Enviornment     = local.environment
    ManagedBy       = "Terraform"
    Project         = "terraform-aws-governed-landingzone-3tier"
    SecurityReview  = "Approved"
  }
}
