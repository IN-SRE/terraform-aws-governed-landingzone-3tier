package main

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_security_group_rule"
    rc.change.after.type == "ingress"
    rc.change.after.from_port == 80
    rc.change.after.cidr_blocks[_] == "0.0.0.0/0"
    msg := "ALB HTTP public access is missing or invalid"
}

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_security_group_rule"
    rc.change.after.type == "ingress"
    rc.change.after.from_port == 443
    rc.change.after.cidr_blocks[_] == "0.0.0.0/0"
    msg := "ALB HTTPS public access is missing or invalid"
}

package main

deny contains msg if {
    some rc in input.resource_changes
    rc.type == "aws_security_group_rule"
    rc.change.after.type == "ingress"
    startswith(rc.address, "module.rdsdb")
    count(rc.change.after.cidr_blocks) > 0
    msg := "DB must allow access only from APP security group"
}