module "shared_vars"{
source = "./shared_vars"
}

variable privatesg_id{}
variable tggparm{}

locals{
env = "${terraform.worskpace}"
amiid_env{
default = "ami-*********"
staging= "ami-********"
production = "ami-********"
}
amiid = "${lookup(local.amiid_env, local.env)}"
}

instancetype_env{
default = "t2_micro"
staging= "t2-micro"
production = "t2-medium"
}
instancetype = "${lookup(local.instancetype_env, local.env)}"
}


keypairname_env{
default = "aws_project_name_kp_staging"
staging= "aws_project_name_kp_staging"
production = "aws_project_name_kp_production"
}
keypairname = "${lookup(local.keypairname_env, local.env)}"


asgsedired_env{
default = "1"
staging= "1"
production = "2"
}
asgsedired = "${lookup(local.asgsedired_env, local.env)}"


asgmax_env{
default = "1"
staging= "1"
production = "2"
}
asgmax = "${lookup(local.asgmax_env, local.env)}"
}

asgmin_env{
default = "2"
staging= "2"
production = "4"
}
asgmin = "${lookup(local.asgmin_env, local.env)}"
}


resource "aws_launch_configuration" "sampleapp_lc" {
  name          = "sampleapp_lc-${local.env}"
  image_id      = "${local.amiid}"
  instance_type = "${local.instancetype}"
  keyname       = "${local.keypairname}" 
  userdata      = "${file("assets/userdata.txt")}"
  security_groups = "${var.privatesg_id}"
}

resource "aws_autoscaling_group" "sampleapp_asg" {
  name                 = "sampleapp_asg-${module.shared_vars.env_suffix}"
  max_size             = "${local.asgmin}"
  min_size             = "${local.asgmin}"
  desired_capacity     = "${local.asgdesired}"
  launch_configuration = "${aws_launch_configuration.sampleapp_lc.name}"
  vpc_zone_identifier  = ["${module.shared_vars.publicsubnet1}"]
  target_group_arns    = "${var.tggrparm}"
  tags = concat(
    [
      {
        "key"                 = "Name"
        "value"               = "SampleApp${module.shared_vars.env_suffix}"
        "propagate_at_launch" = true
      },
      {
        "key"                 = "Envrionment"
        "value"               = "${module.shared_vars.env_suffix}"
        "propagate_at_launch" = true
      },
    ],
    var.extra_tags,
  )
}
