module "private_ec2_asg" {
  source =  "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-ec2-autoscaling?ref=v2.0.1"
  
  
  # Launch Template
  ami_id              = data.aws_ami.amazon_linux_2023.id
  instance_type       = var.instance_type
  key_name            = var.key_name
  security_group_ids  = [module.private_sg.security_group_id]
  user_data_path      = "${path.module}/webserver.sh"
  
  block_device_mappings = {
    root = {
      device_name           = "/dev/xvda"
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }

 
  # Auto Scaling Group
  vpc_zone_identifiers = module.vpc-dev.private_subnets
  min_size              = 2
  max_size              = 10
  desired_capacity      = 2

  # SNS Notifications
  sns_subscription_emails  = ["inder0610@gmail.com"]

  # Scheduled Scaling Actions
  scheduled_actions = {
    scale-up-morning = {
      min_size         = 2
      max_size         = 10
      desired_capacity = 8
      recurrence       = "0 7 * * *"
    }
    scale-down-evening = {
      min_size         = 2
      max_size         = 10
      desired_capacity = 2
      recurrence       = "0 17 * * *"
    }
  }

  # Target Tracking Scaling Policies
  target_tracking_policies = {
    cpu-target-tracking = {
      predefined_metric_type = "ASGAverageCPUUtilization"
      target_value            = 50.0
    }
    alb-request-count = {
      predefined_metric_type   = "ALBRequestCountPerTarget"
      target_value              = 10.0
      estimated_instance_warmup = 120
    }
  }

  tags = {
    Owner = "platform-team"
  }

   project = var.department
   environment = var.environment
   component = "private"
}


### Public EC2 Auto Scaling Group

module "public_ec2_asg" {
  source =  "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-ec2-autoscaling?ref=v2.0.1"
  
  
  # Launch Template
  ami_id              = data.aws_ami.amazon_linux_2023.id
  instance_type       = var.instance_type
  key_name            = var.key_name
  security_group_ids  = [module.public_sg.security_group_id]
  user_data_path      = "${path.module}/webserver-02.sh"
  
  block_device_mappings = {
    root = {
      device_name           = "/dev/xvda"
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }

 
  # Auto Scaling Group
  vpc_zone_identifiers = module.vpc-dev.public_subnets
  min_size              = 1
  max_size              = 2
  desired_capacity      = 1

   project = var.department
   environment = var.environment
   component = "public"
}