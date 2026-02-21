resource "aws_security_group" "vpc-ssh" {
  name = "${local.name}-vpc-ssh"
  vpc_id = module.vpc-project1.vpc_id
  description = "Allow SSH inbound traffic and all outbound traffic"
 tags = {
    Name = "${local.name}-vpc-ssh"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_22" {
security_group_id = aws_security_group.vpc-ssh.id
cidr_ipv4 = "0.0.0.0/0"
 from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22

}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.vpc-ssh.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}

resource "aws_security_group" "vpc-web" {
  name = "${local.name}-vpc-web"
  vpc_id = module.vpc-project1.vpc_id
  description = "Allow web inbound traffic and all outbound traffic"
  tags = {
    Name = "${local.name}-vpc-web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_port_80" {
security_group_id = aws_security_group.vpc-web.id
cidr_ipv4 = "0.0.0.0/0"
 from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

}

resource "aws_vpc_security_group_ingress_rule" "allow_port_443" {
security_group_id = aws_security_group.vpc-web.id
cidr_ipv4 = "0.0.0.0/0"
 from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443

}
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4_web" {
  security_group_id = aws_security_group.vpc-web.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" 
}
