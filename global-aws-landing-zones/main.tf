import {
  to = aws_organizations_organization.main
  id = data.aws_organizations_organization.org.id
}
resource "aws_organizations_organization" "main" {
  feature_set = "ALL"
}