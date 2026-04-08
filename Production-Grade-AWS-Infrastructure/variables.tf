#vpc module variables
variable "vpc_cidr_block" {
  type = string
}
variable "public_subnet_cidr" {
    type = list(string)
  
}
variable "private_subnet_cidr" {
    type = list(string)
  
}
#ec2 module variables
variable "instance_type" {
  type = string
}
variable "ami_id" {
  type = string
}
variable "key_name" {
  type = string
}
variable "key_path" {
  type = string
}


