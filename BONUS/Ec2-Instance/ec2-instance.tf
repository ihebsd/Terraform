provider "aws" {
region = "eu-west-1"
profile = ""

}

variable "vpcid"{
type = "string"
default = "vpc-c2f948a6"
}

resource "aws_security_group" "ec2-instancesg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = $"{var.vpcid}"

  ingress {
    from_port   = 22

    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

variable "amiid" {
default ="ami-********"
}

resource "aws_instance" "terraform_ec2_instance"{
ami = "${var.amiid}"
instance_type = "t2.micro"
key_name = "terraform-cource"
vpc_security_groups_ids = ["${aws_security_group.ec2-instancesg.id}"]

tags{
Name = "Terraform ec2 instance " 
}


