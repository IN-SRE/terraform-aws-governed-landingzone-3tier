locals {
  department = var.department
  environment = "stage"
   name = "${var.department}-${local.environment}"

  common_tag = {
    Department = local.department
    Enviornment = local.environment
  }
}