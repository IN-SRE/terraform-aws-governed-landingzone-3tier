# Get latest AMI ID for linux OS
data "aws_ami" "awslinux" {
  most_recent      = true
  owners           = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.10.20260105.0-kernel-6.1-x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_availability_zones" "Azones" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

 data "aws_ec2_instance_type_offerings" "my_AZ_offer" {
  for_each = toset(data.aws_availability_zones.Azones.names)
  filter {
    name   = "instance-type"
    values = ["t2.micro"]
  }

  filter {
    name   = "location"
    values = [each.key]
  }

  location_type = "availability-zone"
  # we need to define this type as offering to will not understand if it is AZ or local etc. each.key just value for second data loop. it is AZ for first loop only.
}