#Creating VPC and subnets
resource "aws_vpc" "HAvpc" {
  
cidr_block = var.vpc_cidr_block



tags = {
      Name = "HAVPC"
    }   
  
}

#fetching availability zone data to create subnets in different availability zones for high availability
data "aws_availability_zones" "available" {
    state = "available"
  
}

#creating public and private subnets using count to create multiple subnets based on the length of the cidr block list provided in terraform.tfvars file
resource "aws_subnet" "public_subnet" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.HAvpc.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]
    map_public_ip_on_launch = true


    tags = {
      Name = "public subnet ${count.index +1}"
    }

}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.HAvpc.id
  count =  length(var.private_subnet_cidr)
    cidr_block = var.private_subnet_cidr[count.index]
    availability_zone = data.aws_availability_zones.available.names[count.index]
    tags = {
      Name = "private subnet ${count.index}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.HAvpc.id

  tags =  {
      Name = "HAIGW"
    }   
  
}

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.HAvpc.id
    count = length(aws_subnet.public_subnet)
    
    tags = {
      Name = "public RT ${count.index + 1}"
    }

}


resource "aws_route_table" "private_route" {
    vpc_id = aws_vpc.HAvpc.id
    count = length(aws_subnet.private_subnet)
    
    tags = {
      Name = "private RT ${count.index + 1}"
    }

}
resource "aws_route_table_association" "public_rt" {
    subnet_id = aws_subnet.public_subnet[count.index].id
    route_table_id = aws_route_table.public_route[count.index].id
    count = length(aws_subnet.public_subnet)
  
}

resource "aws_route_table_association" "private_rt" {
    subnet_id = aws_subnet.private_subnet[count.index].id
    route_table_id = aws_route_table.private_route[count.index].id
    count = length(aws_subnet.private_subnet)
  
}

resource "aws_eip" "static_ip" {
    domain = "vpc"
    count = length(aws_subnet.public_subnet)
}

resource "aws_nat_gateway" "nta" {
    allocation_id = aws_eip.static_ip[count.index].id
    subnet_id = aws_subnet.public_subnet[count.index].id
    count = length(aws_subnet.public_subnet)
    depends_on = [ aws_eip.static_ip ]


    tags = {
      Name = " NAT ${count.index + 1}"
    }
  

}

resource "aws_route" "private_route" {
    route_table_id = aws_route_table.private_route[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nta[count.index].id
    count = length(aws_subnet.private_subnet)

}

resource "aws_route" "public_route" {
    route_table_id = aws_route_table.public_route[count.index].id
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
    count = length(aws_subnet.public_subnet)
  
}






