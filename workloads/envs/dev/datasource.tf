data "aws_ami" "amazon_linux_2023" {
most_recent = true
owners = [ "amazon" ]

filter {
  name = "architecture"
  values = ["x86_64" ]
}

filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
}


# Data for domain name
data "aws_route53_zone" "my_dns_zone" {
  name         = "tomarinfralab.click"
  private_zone = false
}