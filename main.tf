
// vpc creation//

resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "testVPC"
  }
}

// internet gateway creation //

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "IGW"
  }
}


// public subnet//
resource "aws_subnet" "public_subnet" {
    count = length(var.availability_zone)
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = element(var.public_subnet, count.index)
    availability_zone = element(var.availability_zone, count.index)

    tags = {
      Name = "public subnet ${count.index + 1}"
    }
  
}


// route table//

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/16"
    gateway_id = aws_internet_gateway.IGW.id
  }

  tags = {
    Name = "route table"
  }
}


// route table public subnet association //

resource "aws_route_table_association" "pub_sub_route_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_RT
}

//private subnet//

resource "aws_subnet" "Private_subnet" {
  count = length(var.availability_zone)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = element(var.Private_subnet, count.index)
  availability_zone = element(var.availability_zone, count.index)

  tags =  {
    Name = "private subnet ${count.index + 1}"
  }
}


// NAT gateway //

resource "aws_eip" "Elastic_ip" {
    vpc = true
    depends_on = [ aws_internet_gateway.IGW ]

  
}

resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.Elastic_ip.id
  subnet_id     = aws_subnet.Private_subnet.id

  tags = {
    Name = "NAT GW"
  }
}
// route table for private subnet//


resource "aws_route_table" "Private_RT" {
    vpc_id = aws_vpc.my_vpc.id

    route = {
        cidr_block = "10.0.0.0/16"

    }
  
}

resource "aws_route_table_association" "prt_sub_route_association" {
    subnet_id = aws_subnet.Private_subnet.id
    route_table_id = aws_route_table.Private_RT.id
    gateway_id = aws_nat_gateway.NAT_GW.id
  
}


