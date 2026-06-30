output "OU_Dev" {
    value = data.aws_organizations_organization.org.accounts
  
}

output "audit_account_id" {
    value = aws_organizations_account.Audit.id
  
}
output "log_archive_account_id" {
    value = aws_organizations_account.Log_archive.id
  
}
output "sandbox_account_id" {
    value = data.aws_organizations_account.devop.account_id
  
}

output "x" {
    value = aws_organizations_organization.main.accounts
  
}