output "vpcid"{
value = "${local.vpcid}"
}

output "publicsubnetid1"{
value ="${local.publicsubnetid1}"
}

output "publicsubnetid2"{
value ="${local.publicsubnetid2}"
}

output "privatesubnetid"{
value ="${local.privatesubnetid}"
}

output "env_suffix"{
value = "${local.env}"
}


locals {
env = "${terraform.workspace}"

vpcid_env{
default = "vpc-*********"
staging= "vpc-********"
production = "vpc-********"
}
vpcid = "${lookup(local.vpcid_env, local.env)}"
}

publicsubnetid1_env{
default = "subnet-*********"
staging= "subnet-********"
production = "subnet-********"
}
publicsubnetid1 = "${lookup(local.publicsubnetid1_env, local.env)}"
}

publicsubnetid2_env{
default = "subnet-*********"
staging= "subnet-********"
production = "subnet-********"
}
publicsubnetid2 = "${lookup(local.publicsubnetid2_env, local.env)}"
}

privatesubnetid_env{
default = "subnet-*********"
staging= "subnet-********"
production = "subnet-********"
}
privatesubnetid = "${lookup(local.privatesubnetid_env, local.env)}"
}



}
