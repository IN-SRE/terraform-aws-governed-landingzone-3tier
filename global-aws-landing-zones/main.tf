import {
  to = aws_organizations_organization.main
  id = data.aws_organizations_organization.org.id
}
resource "aws_organizations_organization" "main" {
  feature_set = "ALL"
}


resource "aws_organizations_organizational_unit" "sandbox" {
  name = "Sandbox"
  parent_id = aws_organizations_organization.main.roots[0].id
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


################################################################################
# IAM Role
################################################################################
# AWSControlTowerAdmin

resource "aws_iam_role" "aws_controltower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"
  description = "Role used by AWS Control Tower to administer the landing zone." 

  assume_role_policy = jsonencode(
  {
  "Version":"2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "controltower.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
})
  tags = local.common_tag
}

# Inline Policy - AWSControlTowerAdminPolicy ; Permission specific only to this role

resource "aws_iam_role_policy" "aws_controltower_admin_policy" {
  name = "AWSControlTowerAdminPolicy"
  role = aws_iam_role.aws_controltower_admin.id
   policy = jsonencode({
    "Version":"2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "ec2:DescribeAvailabilityZones",
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_role_policy_attachment" "aws_controltower_service_role_policy" {

  role = aws_iam_role.aws_controltower_admin.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}


# AWS Control Tower CloudTrail Role

resource "aws_iam_role" "aws_controltower_cloudtrail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"
  description = "Role used by CloudTrail to send logs to CloudWatch."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = local.common_tag
}

# Attach AWS Managed Policy: AWSControlTowerCloudTrailRolePolicy

resource "aws_iam_role_policy_attachment" "aws_controltower_cloudtrail_role_policy" {
  role       = aws_iam_role.aws_controltower_cloudtrail_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerCloudTrailRolePolicy"
}


# AWS Control Tower StackSet Role

resource "aws_iam_role" "aws_controltower_stackset_role" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"
  description = "Role used by CloudFormation StackSets to deploy resources across accounts."

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "cloudformation.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
  tags = local.common_tag
}

# Inline Policy: Allow CloudFormation to assume AWSControlTowerExecution role

resource "aws_iam_role_policy" "aws_controltower_stackset_role_policy" {
  name = "AWSControlTowerStackSetRolePolicy"
  role = aws_iam_role.aws_controltower_stackset_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "sts:AssumeRole"
        ]
        Resource = [
          "arn:aws:iam::*:role/AWSControlTowerExecution"
        ]
      }
    ]
  })
}

################################################################################
# Launch landing zone
################################################################################

resource "aws_kms_key" "kms_config" {
  description             = "Landing Zone KMS key"
  enable_key_rotation     = true
  multi_region            = false
  deletion_window_in_days = 7

  tags = {
    Name = "lz-kms"
  }
}

resource "aws_controltower_landing_zone" "lz" {
  manifest_json     = templatefile("${path.module}/lz-gov-manifest.json", { 
    common_account = data.aws_organizations_account.devop.account_id
    log_archieve= aws_organizations_account.Log_archive.id
    security_audit= aws_organizations_account.Audit.id
    kms_key_arn = aws_kms_key.kms_config.arn
    })
  version           = "4.0"
  remediation_types = ["INHERITANCE_DRIFT"]
  region = "us-east1, us-west-1"
  tags = local.common_tag
  
}





