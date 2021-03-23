# AWS settings
variable "profile"      { default = "test" }

variable "region"       { default = "eu-central-1" } 
variable "zones"         { default = ["eu-central-1a", "eu-central-1b"] } 

# Tech variables
variable "cidr"         { default = "10.20.0.0/16" }

# User variables
variable "vpc-name"     { default = "biz-test" }
#variable "domain-name"  { default = "biz.zone" } 
variable "domain-name"  { default = "abara.bash" } 

# Subnets
variable "subnets-count"    { default = 2 }
variable "public_subnets" {
    type = list(string)
    default = ["10.20.10.0/23", "10.20.20.0/23"]
}

variable "private_subnets" {
    type = list(string)
    default = ["10.20.60.0/23", "10.20.70.0/23"]
}
