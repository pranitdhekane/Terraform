provider "aws" {

  region = "ap-south-1"
}


resource "aws_key_pair" "deployer" {

  key_name   = "my-key"
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

resource "aws_instance" "my_instance" {
  ami                    = "ami-02d26659fd82cf299"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name        = "Demo terraform"
    Environment = "development"
  }

}

output "print_public_ip" {
  value = aws_instance.my_instance.public_ip

}
