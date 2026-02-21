# Ec2 instance public ip
/*output "instance_public_ip" {
description = "Ec2 instance public IP"
value = aws_instance.MyEC2_first.public_ip
  
}

output "instance_public_dns" {
description = "Ec2 instance public DNS"
value = aws_instance.MyEC2_first.public_dns

}*/

# Splat dont work with for_each as it will take only count but for_each give string or map
/* output "latest_splat_instance" {
  description = "for loop for splat operator"
  value = aws_instance.MyEC2_first[*].public_ip
} */     

output "vpc_id" {
  value = module.vpc-project1.vpc_id
  
}

output "private_subnets" {
  value = module.vpc-project1.private_subnets[0]
  
}