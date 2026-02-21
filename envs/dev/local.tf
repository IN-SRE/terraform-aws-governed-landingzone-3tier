locals {
  department = var.department
  environment = "dev"
  name = "${var.department}-${local.environment}"

  common_tag = {
    Department = local.department
    Enviornment = local.environment
  }
}