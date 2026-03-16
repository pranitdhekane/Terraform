variable "VPC_CIDR" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
  
}

variable "PUBLIC_SUBNET_CIDR" {
    description = "CIDR block for the public subnet"
    type        = string
    default     = "10.0.1.0/24"
}

variable "PRIVATE_SUBNET_CIDR" {
    description = "CIDR block for the private subnet"
    type        = string
    default     = "10.0.2.0/24"
}

