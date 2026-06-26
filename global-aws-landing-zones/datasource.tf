data "aws_organizations_organization" "org" {}
data "aws_organizations_account" "devop" {
account_id = aws_organizations_organizational_unit.sandbox.accounts[0].id
}