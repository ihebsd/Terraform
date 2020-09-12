provider "aws" {
    region = "eu-west-1"
    profile = ""
}

module "ec2_module"{
source ="./ec2_module"
}
