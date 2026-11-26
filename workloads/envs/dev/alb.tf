module "alb" {
  source = "git::https://github.com/IN-SRE/terraform-aws-infrastructure-modules.git//tf-aws-alb?ref=alb-v1.0.0"
  

  name = "${local.name}-alb"
  vpc_id = module.vpc-dev.vpc_id
  subnets = module.vpc-dev.public_subnets
  security_group_ids = [ module.alb_sg.security_group_id ]
  enable_deletion_protection = false
  idle_timeout = 60
  drop_invalid_header_fields = true
 #listeners 
  listeners = {
    # first listener
     my-http-https-redirect = {
    
    port                 = 80
    protocol             = "HTTP"
    default_action_type  = "redirect"
    redirect_port        = "443"
    redirect_protocol    = "HTTPS"
    redirect_status_code = "HTTP_301"
      }
      
    # End my-http-https-redirect Listener
    
    #second listener
    my-https-listener = {
      port = "443"
      protocol = "HTTPS"
       ssl_policy = "ELBSecurityPolicy-TLS13-1-2-Res-2021-06"
       target_group_key = "mytg1"
       default_action_type  = "forward"
       certificate_arn = module.acm.acm_certificate_arn

      fixed_response = {
        content_type = "text/plain"
        message_body = "Fixed Static message - for Root Context"
        status_code  = "200"
      }# End of Fixed Response
      
     } # End of my-https-listener
   
  }


      # Load Balancer Rules
      listener_rules = {
        # Rule-1: myapp1-rule
        myapp1-rule = {
        
        listener_key     = "my-https-listener"
        priority         = 1
        target_group_key = "mytg1"
        path_patterns    = ["/*"]
                     }# End of myapp1-rule
         }# End of listener_rules
    


target_groups = {
    #first target group
    mytg1 = {
     name  = "mytg1-"
     protocol = "HTTP"
     port = "80"
     target_type = "instance"
     deregistration_delay = 10
     enabled             = true
     health_check_interval = 30
     health_check_path   = "/webserver/index.html"
     healthy_threshold   = 3
     unhealthy_threshold = 3
     health_check_timeout = 6
     protocol            = "HTTP"
     health_check_matcher = "200-399"
      # End of health_check Block
       tags = local.common_tags # Target Group Tags 
    }# END of Target Group: mytg1
} # END OF target_groups Block
 tags = local.common_tags # ALB Tags 

}