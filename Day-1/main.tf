# main.tf

provider "aws" {
  region = "ap-south-1" 
}

resource "aws_instance" "example" {
  ami           = "ami-0b982602dbb32c5bd" # Amazon Linux 2 AMI (for ap-south-1)
  instance_type = "t2.micro"              # Free-tier eligible
  key_name      = "mac"

  tags = {
    Name = "MySimpleEC2"
  }
}
resource "aws_security_group_rule" "allow_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"] 
  security_group_id = "sg-0521e7d8f18693e15" # existing SG ID

  
}




