variable "public_sg_id"{
}


module "shared_vars"{
source = "./shared_vars"
}

resource "aws_lb" "sampleapp_alb" {
  name               = "sampleapp_alb-${module.shared_vars.env_suffix}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_sg_id]
  subnets            = ["${module.shared_vars.publicsubnetid1}","${module.shared_vars.publicsubnetid2}" ]

  enable_deletion_protection = true

  tags = {
    Environment = "module.shared_vars.env_suffix"
  }
}

resource "aws_lb_target_group" "sampleapp_http_target" {
  name     = "sampleapp_http_target{module.shared_vars.env_suffix}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${module.shared_vars.vpcid}"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = "${aws_lb.sampleapp_alb.arn}"
  port              = "80"
  protocol          = "HTTP"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.sampleapp_http_target.arn}"

  }
}


