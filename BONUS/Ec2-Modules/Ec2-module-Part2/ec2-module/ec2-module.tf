
variable "amiid" {
default ="ami-********"
}

variable "sg_id" {}
variable "ec2_name" {}


resource "aws_instance" "terraform_ec2_instance"{
ami = "${var.amiid}"
instance_type = "t2.micro"
key_name = "Ec2 instance from module"
vpc_security_groups_ids = ["${var.sg_id}"]

tags{
Name = "var.ec2_name " 
}

