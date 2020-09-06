resource "aws_vpc" "vpc" {
  cidr_block = var.vpc-cidr-block
}

data "aws_availability_zones" "az" {
}
/*-----------------------PUBLIC-SUBNET---------------------------------*/
resource "aws_subnet" "public-subnet" {
  count = length(var.az_num)
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc-cidr-block, 8, count.index + 1)
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.az.names[var.az_num[count.index]]
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.vpc.id
}

resource "aws_route_table" "internet-gw-rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table_association" "internet-gw-rt-association" {
  count = length(var.az_num)
  subnet_id = aws_subnet.public-subnet[count.index].id
  route_table_id = aws_route_table.internet-gw-rt.id
}
/*----------------------------PRIVATE-SUBNET--------------------------------*/
locals {
  nat-gw-count = var.nat-gw-for-every-subnet?length(var.az_num):1
}

resource "aws_subnet" "private-subnet" {
  count = length(var.az_num)
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet(var.vpc-cidr-block, 8, length(aws_subnet.public-subnet) + count.index + 1)
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.az.names[var.az_num[count.index]]
}

resource "aws_eip" "nat-gw-eip" {
  count = local.nat-gw-count
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  count = local.nat-gw-count
  allocation_id = aws_eip.nat-gw-eip[count.index].id
  subnet_id = aws_subnet.public-subnet[count.index].id
}

resource "aws_route_table" "nat-gw-rt" {
  count = local.nat-gw-count
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat-gw[count.index].id
  }
}

resource "aws_route_table_association" "nat-gw-rt-association" {
  count = length(var.az_num)
  subnet_id = aws_subnet.private-subnet[count.index].id
  route_table_id = aws_route_table.nat-gw-rt[var.nat-gw-for-every-subnet?count.index:0].id
}