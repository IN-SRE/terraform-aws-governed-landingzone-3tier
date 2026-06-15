import {
  to = aws_organizations_organization.main
  id = data.aws_organizations_organization.org.id
}
resource "aws_organizations_organization" "main" {
  feature_set = "ALL"
}

# Security OU created for centralized governance of security and audit accounts
resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = aws_organizations_organization.main.roots[0].id
}

# Provision a dedicated Log Archive account to centralize organization-wide log storage and retention.
resource "aws_organizations_account" "Log_archive" {
  name  = "Logging Account"
  email = var.log_archive
  iam_user_access_to_billing = "DENY"
  parent_id = aws_organizations_organizational_unit.security.id
  tags = local.common_tag
}

# A dedicated Audit account is provisioned within the Security OU for organization-wide security monitoring and compliance operations.
resource "aws_organizations_account" "Audit" {
  name  = "Security Account"
  email = var.audit
  iam_user_access_to_billing = "DENY"
  parent_id = aws_organizations_organizational_unit.security.id
  tags = local.common_tag
}
