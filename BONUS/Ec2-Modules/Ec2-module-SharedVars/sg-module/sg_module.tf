module "shared_vars"{
source = "../shared_vars"
}

resource "aws_security_group" "sg_module_creation" {
  name        = "sg_name${module.shared_vars.env_suffix}"
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

output "sg_module_output"{
value = $"{var.aws_security_group.sg_module_creation.id}"
}
