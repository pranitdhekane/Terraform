provider "aws" {
  region = "ap-south-1"

}


resource "aws_key_pair" "my_key" {
  key_name   = "my-terraform-key"
  public_key = file("~/.ssh/my-terraform-key.pub")
}
resource "aws_instance" "demo" {
  ami                         = "ami-01b6d88af12965bb6"
  instance_type               = "t2.micro"
  subnet_id                   = "subnet-02b8b5313a0ac4bc3"
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "MyFirstInstance"
  }





}

resource "aws_s3_bucket" "name" {
  bucket = "pranit-demo-xyzyyz-unique-bucket-name-1234567890"
}

resource "aws_s3_bucket_versioning" "name_versioning" {
  bucket = aws_s3_bucket.name.id
  versioning_configuration {
    status = "Enabled"
  }
}




resource "aws_security_group_rule" "allow_80" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "sg-0521e7d8f18693e15"

}
output "instance_public_ip" {
  value = aws_instance.demo.public_ip

}


