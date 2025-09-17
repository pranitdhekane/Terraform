provider "aws" {
    region = "ap-south-1"
}

variable "ami_id" {
    description = "value of AMI ID"
    type        = string
  
}
variable "instance_type" {
    description = "value of instance type"
    type        = string
    
  
}

variable "subnet" {
    description = "value of subnet id"
    type        = string
  
}



resource "aws_instance" "myec2" {
    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet
    key_name = aws_key_pair.mykey.key_name
  

}
resource "aws_key_pair" "mykey" {
    key_name   = "my-terraform-key"
    public_key = file("/Users/pranitdhekane/.ssh/my-terraform-key.pub")
}
resource "aws_security_group" "allow_ssh" {

  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  ingress {

    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  egress {

    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}