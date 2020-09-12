
variable "amiid" {
default ="ami-********"
}

module "shared_vars"{
source = "../shared_vars"
}

variable "sg_id" {}


resource "aws_instance" "terraform_ec2_instance"{
ami = "${var.amiid}"
instance_type = "t2.micro"
key_name = "Ec2 instance from module"
vpc_security_groups_ids = ["${var.sg_id}"]

tags{
Name = "EC2_Name_Instance${module.shared_vars.env_suffix " 
}


