module "rdsdb" {
  source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-rds?ref=rds-v1.0.0"

  identifier = "webapp-dev-db"

  engine                 = "mysql"
  engine_version         = "8.0"
  parameter_group_family = "mysql8.0"
  major_engine_version   = "8.0"
  instance_class         = "db.t3.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = true

  db_name  = "webappdb"
  username = "dbadmin"
  password = "12345678"
  port     = 3306

  db_subnet_group_name   = "DB-Group-${local.name}"
  vpc_security_group_ids = [module.vpc-dev.vpc_id]
  multi_az               = false

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 7

  enabled_cloudwatch_logs_exports = ["general", "error"]
  create_cloudwatch_log_group     = true
  cloudwatch_log_retention_days   = 14

  skip_final_snapshot = true
  deletion_protection = false

  performance_insights_enabled          = false
  performance_insights_retention_period = 7
  create_monitoring_role                = true
  monitoring_interval                   = 60

  parameters = [
    { name = "character_set_client", value = "utf8mb4" },
    { name = "character_set_server", value = "utf8mb4" }
  ]

  tags                      = local.common_tags
  db_instance_tags          = { Sensitive = "high" }
  db_option_group_tags      = { Sensitive = "low" }
  db_parameter_group_tags   = { Sensitive = "low" }
  cloudwatch_log_group_tags = { Sensitive = "high" }
}