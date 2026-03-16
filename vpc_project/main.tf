#This is a file for creating vpc with pubic private subnet and ec2 instance in public subnet.
provider "aws" {
  region = "ap-south-1"

}

resource "aws_vpc" "demo_vpc" {
  cidr_block = var.VPC_CIDR
  tags = {
    Name = "Demo_VPC"
  }

}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.PUBLIC_SUBNET_CIDR

  tags = {
    Name = "Public Subnet"
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = var.PRIVATE_SUBNET_CIDR
  tags = {
    Name = "Private Subnet"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "Demo_IG"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "Public_RT"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.demo_vpc.id
  tags = {
    Name = "Private_RT"
  }

}

resource "aws_route_table_association" "public_rt" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id

}
resource "aws_route_table_association" "private_rt" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id

}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

#use of aws_eip and aws_nat_gateway to create nat gateway in public subnet and attach it with private route table for internet access to private subnet.

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name = "Demo_NAT_EIP"
  }

}
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "Demo_NAT"
  }

}
resource "aws_route" "private-rt" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id

}
