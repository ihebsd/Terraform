provider "aws" {
    region = "eu-west-1"
    profile = ""
}

module "shared_vars"{
source ="shared_vars"
}


module "ec2_module"{
sg_id ="${module.sg_module.sg_module_output}"
ec2_name ="EC2 instance_${local.env}"
source ="./ec2-module"
}


module "sg_module"{
sg_name = "sg_ec2_${local.env}"
source ="./sg_module"
}

locals {
env = "${terraform.workspace}"

amiid_env{
default = "amiid_default"
staging= "amiid_staging"
production = "amiid_production"
}
amiid = "${lookup(local.amiid_env, local.env)}"
}

output "envspecicouput_variable"{
value = "${local.amiid}"
}

