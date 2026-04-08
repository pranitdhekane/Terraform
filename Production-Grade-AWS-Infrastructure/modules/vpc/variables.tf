variable "vpc_cidr_block" {
  type = string
}
variable "public_subnet_cidr" {
    type = list(string)
  
}
variable "private_subnet_cidr" {
    type = list(string)
  
}
