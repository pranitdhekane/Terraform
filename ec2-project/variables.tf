variable "region" {
  description = "The AWS region to deploy resources in"
}
variable "instance_type" {
  description = "The EC2 instance type to launch"
}
variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
}
variable "vpc_id" {
    description = "The VPC ID to launch the EC2 instance in"
  
}
variable "subnet_id" {
    description = "The Subnet ID to launch the EC2 instance in"
  
}

variable "public_key" {
    description = "The path to the public key file for SSH access"
  
}
