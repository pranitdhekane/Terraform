# This file is used to set the values of the variables defined in the Terraform configuration. You can customize the values as needed for your specific use case.

# VPC configuration variables
vpc_cidr_block = "172.168.0.0/16"
public_subnet_cidr = [
    "172.168.1.0/24",
    "172.168.2.0/24"
]

private_subnet_cidr = [
    "172.168.3.0/24",
    "172.168.4.0/24"
]



# EC2 instance configuration variables
instance_type = "t2.micro"
ami_id = "ami-0ec10929233384c7f"
key_name = "id_ed25519"
key_path = "~/.ssh/id_ed25519.pub"
