provider "aws"{
profile = "*********"
region = "us-east-2"
}

module "loadbalancer_module" {
source ="./loadBalancer"
public_sg_id= "${module.network_module.public_sg_id}"
}

module "network_module"{
source = "./network_module"
}

module "autoscaling_module"{
source = "./autoscaling"
privatesg_id= "${module.network_module.private_sg_id}"
tggparm= "${module.loadbalancer.tggparm}"
}

