module "shared_vars"{
source ="./shared_vars"
}

resource "aws_security_group" "public_sg" {
  name        = "${public_sg${module.shared_vars.env_suffix}}"
  description = "public security group"
  vpc_id      = $"{module.shared_vars.vpcid}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_sg_id"{
value = "${aws_security_group.public_sg.id}"
}

resource "aws_security_group" "private_sg" {
  name        = "${sg_name${module.shared_vars.env_suffix}}"
  description = "private_sg"
  vpc_id      = $"{module.shared_vars.vpcid}"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_group = ["${aws_security_group.public_sg.id}"]
  }
}

output "private_sg_id"{
value = "${aws_security_group.private_sg.id}"
}


