locals {
  department = var.department
  environment = "qa"
 name = "${var.department}-${local.environment}"

  common_tag = {
    Department = local.department
    Enviornment = local.environment
  }
}