provider "aws" {
    region = "eu-west-1"
    profile = ""
}

# Declaring variables

variable "firststring" {
type = "string"
default = "this is my first string"

}

variable "multilinestring" {
type = "string"
default = <<EOH
this is a multiline
string
newline
EOH
}

output "multilinestringput"{
value="${var.multilinestring}"
}


output "myfirstoutput"{
value= "${var.firststring}"
}

# Map example

variable "mapexample"{
type = "map"
default = {
"useast" = "ami1"
"euwest" = "ami2"
}
}

output "mapoutput" {
 value = "${var.mapexample["useast"]}"

}
variable "mysecuritygrouplist" {
type = "list"
default = ["sg1","sg2","sg3"]
}

output "sgoutput" {
value = "${var.mysecuritygrouplist[0]}"
}

variable "testbool"{
default = "false"
}

output "booloutput"{
value = "${var.testbool}"
}

variable "myInputVariable"{
type = "string"
}

output "myOutputVariable"{
sensitive = true 
value = "${var.myInputVariable}"
}
