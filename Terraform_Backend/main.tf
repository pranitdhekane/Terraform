provider "aws" {
  region = "ap-south-1"
}




resource "aws_key_pair" "demo" {

  key_name   = "demo-key"
  public_key = file("~/.ssh/id_ed25519.pub")

}

resource "aws_instance" "demo" {
  ami    = "ami-0a14f53a6fe4dfcd1"
  subnet_id = "subnet-0e0c4d6879b83a2ce"
  instance_type = "t2.micro"
  key_name = aws_key_pair.demo.key_name


  tags = {
    Name = "demo-instance"

  }

}



