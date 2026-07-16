module "aft" {
  source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-ct-aft?ref=tf-aws-ct-aft/v1.0.0"
    
  ct_management_account_id    = data.aws_organizations_organization.org.master_account_id
  log_archive_account_id      = aws_organizations_account.Log_archive.id
  audit_account_id            = aws_organizations_account.Audit.id
  aft_management_account_id   = data.aws_organizations_organization.org.master_account_id
  ct_home_region              = var.aws_region
  terraform_version           = var.terraform_version

  vcs_provider                                  = "github"
  account_request_repo_name                     = "${var.github_username}/terraform-aws-governed-landingzone-3tier"
  account_provisioning_customizations_repo_name = "${var.github_username}/terraform-aws-governed-landingzone-3tier"
  global_customizations_repo_name               = "${var.github_username}/terraform-aws-governed-landingzone-3tier"
  account_customizations_repo_name              = "${var.github_username}/terraform-aws-governed-landingzone-3tier"
}