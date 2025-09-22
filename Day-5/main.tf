provider "aws" {
  region = var.region

}
# VPC Creation
resource "aws_vpc" "test" {

  cidr_block = var.vpc_cidr
  region     = var.region

  tags = {
    Name = "test vpc"
  }
}



# Internet Getway creation
resource "aws_internet_gateway" "test" {
  vpc_id = aws_vpc.test.id

  tags = {
    Name = "Test GW"
  }
}


# Route Table Creation
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.test.id
  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test.id

  }

  tags = {

    Name = "PublicRT"
  }

}


#Route Table Association

resource "aws_route_table_association" "publicRT" {

  route_table_id = aws_route_table.public.id

  subnet_id = aws_subnet.Pulic_subnet.id

}



# Subnet Creation
resource "aws_subnet" "Pulic_subnet" {
  vpc_id                  = aws_vpc.test.id
  cidr_block              = var.publicsubnet_cidr
  availability_zone       = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "public subnet"
  }
}


# Keypair for EC2 Access 
resource "aws_key_pair" "example" {

  key_name   = "my-terraform-key" # name that will be registered in AWS
  public_key = file("~/.ssh/id_rsa.pub")

}


# Security Groups for EC2
resource "aws_security_group" "websg" {
  name        = "web"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.test.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "web"
  }
}

# Creation of EC2 Instance

resource "aws_instance" "demo" {
  ami = var.ami_id
  instance_type = var.instance-type
  subnet_id = aws_subnet.Pulic_subnet.id
  key_name = aws_key_pair.example.key_name
  vpc_security_group_ids = [ aws_security_group.websg.id ]
  tags = {
    Name = "Webserver"
  }
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/Users/pranitdhekane/.ssh/id_rsa")
    host = self.public_ip
  }
  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"

  }
  provisioner "remote-exec" {
    inline = [  
    "echo 'Hello from remote instance'",
    "sudo apt update -y",
    "sudo apt install python3-pip -y",
    "cd /home/ubuntu",
    "sudo pip3 install flask",
    "sudo python3 app.py &",    
    ]
  }

}


