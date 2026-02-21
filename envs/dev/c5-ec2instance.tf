# Resource Block
resource "aws_instance" "MyEC2_first" {
  ami = data.aws_ami.awslinux.id
  instance_type = var.aws_instance_type
  //instance_type = var.aws_instancetype_list [0]
  //instance_type = var.aws_instancetype_map["dev"]
  user_data = file("${path.module}/webserver_ec2.sh")
  key_name = var.aws_ec2_keypair
  subnet_id = module.vpc-project1.private_subnets[0]
  vpc_security_group_ids = [ aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id ]
  tags = {
    Name = "${local.name}-EC2"
  }
  # create EC2 instance for each availablity zones where architecture permits.
  //for_each = toset(keys({for c, x in data.aws_ec2_instance_type_offerings.my_AZ_offer: c => x.instance_types if length(x.instance_types) != 0 }) )
# keys give only keys data not value data, we applied map so it give key and value

  # without toset it give list value which for_each dont accept as it accept strings and map
//availability_zone = each.key
//tags = {
   // "Name" = "webserver on ec2-${each.key}"
 # comment section create number of EC2 instance
  /* count = 3
  tags = {
    "Name" = "webserver on ec2-${count.index}"
  } */
} 
