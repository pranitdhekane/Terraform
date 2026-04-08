variable "instance_type" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "key_name" {
  type = string
}

variable "vpc_id" {
  type = string
}

# EC2 private subnets (ASG)
variable "subnet_ids" {
  type = list(string)
}

# ALB public subnets
variable "alb_subnet_ids" {
  type = list(string)
}

# SGs from sgs module
variable "instance_sg_id" {
  type = string
}

variable "alb_sg_id" {
  type = string
}