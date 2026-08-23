locals {
  department = var.department
  enviornment = var.environment
  name = "${var.department}-${var.environment}"

  common_tags ={
    Department = local.department
    Environment = local.enviornment

  }
}
