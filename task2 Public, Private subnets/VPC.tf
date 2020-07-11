provider "aws" {
region = "ap-south-1"
profile = "abhi"
}

resource "aws_vpc" "create_vpc" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = "true"
  tags = {
    Name = "abhivpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = "${aws_vpc.create_vpc.id}"
  cidr_block = "192.168.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = "${aws_vpc.create_vpc.id}"
  cidr_block = "192.168.2.0/24"
  #map_public_ip_on_launch = "true"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private"
  }
}
resource "aws_internet_gateway" "abhiigw" {
  vpc_id = "${aws_vpc.create_vpc.id}"

  tags = {
    Name = "abhiigw"
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = "${aws_vpc.create_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.abhiigw.id}"
  }

  
  tags = {
    Name = "route_table"
  }
}


  

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.route_table.id
}


