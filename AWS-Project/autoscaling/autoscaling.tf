module "shared_vars"{
source = "./shared_vars"
}

variable privatesg_id{
}

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
}

resource "aws_launch_configuration" "sampleapp_lc" {
  name          = "sampleapp_lc-${local.env}"
  image_id      = "${local.amiid}"
  instance_type = "${local.instancetype}"
  keyname       = "${local.keypairname}" 
  userdata      = "${file("assets/userdata.txt")}"
  security_groups = "${var.privatesg_id}"
}
