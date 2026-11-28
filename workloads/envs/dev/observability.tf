module "observability" {
  source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-observability?ref=observability-v1.0.0"

  name          = "dev-app"
  sns_topic_arn = module.private_ec2.sns_topic_arn
  tags          = { Environment = "dev", ManagedBy = "terraform" }

  # ALB (from module.alb.lb_arn_suffix)
  enable_alb_alarms          = true
  alb_arn_suffix             = module.alb.lb_arn_suffix
  alb_5xx_threshold          = 5
  alb_5xx_evaluation_periods = 3
  alb_5xx_period             = 120

  # ASG
  enable_asg_alarms          = true
  autoscaling_group_name     = module.private_ec2.autoscaling_group_name
  asg_scale_out_adjustment   = 4
  asg_scale_out_cooldown     = 300
  asg_cpu_threshold          = 80
  asg_cpu_evaluation_periods = 2
  asg_cpu_period             = 120

  # CIS
  enable_cis_alarms      = true
  cis_log_group_name     = "/cis/cloudtrail"
  cis_log_retention_days = 90 # not in your scripts; set as needed
  cis_disabled_controls  = ["DisableOrDeleteCMK", "VPCChanges"]

  # Synthetics
  enable_synthetics                 = true
  canary_name                       = "sswebsite2"
  canary_zip_file                   = "sswebsite2/sswebsite2v1.zip"
  canary_handler                    = "sswebsite2.handler"
  canary_runtime_version            = "syn-nodejs-puppeteer-13.1"
  canary_schedule                   = "rate(1 minute)"
  canary_memory_in_mb               = 960
  canary_timeout_in_seconds         = 60
  canary_success_threshold          = 80
  canary_success_evaluation_periods = 5
  canary_success_period             = 300
}