provider "aws" {
    region = "eu-west-1"
    profile = ""
}

module "ec2_module"{
sg_id ="${module.sg_module.sg_module_output}"
ec2_name ="EC2 instance from modules"
source ="./ec2-module"
}

#You can reuse the module to create another EC2 instance

module "ec2_module num 2"{
sg_id ="${module.sg_module.sg_module_output}"
ec2_name ="EC2 instance from modules"
source ="./ec2-module"
}

module "sg_module"{
source ="./sg_module"
}
 
