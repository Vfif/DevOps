resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc-cidr-block
}

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test-vpc.id
}

data "aws_availability_zones" "az" {
}

resource "aws_subnet" "test-public-subnet" {
  count = length(var.availability_zones_num)
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = cidrsubnet(var.vpc-cidr-block, 8, count.index + 1)
  map_public_ip_on_launch = "true"
  availability_zone = data.aws_availability_zones.az.names[var.availability_zones_num[count.index]]
}
//todo
/*resource "aws_subnet" "test-private-subnet" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = cidrsubnet(var.vpc-cidr-block, 8, count.index + 1)
  map_public_ip_on_launch = "false"
  availability_zone = data.aws_availability_zones.az.names[count.index]
}*/


resource "aws_route_table" "test-rt" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }
}

resource "aws_route_table_association" "test-rt-association"{
  count = length(var.availability_zones_num)
  subnet_id      = aws_subnet.test-public-subnet[count.index].id
  route_table_id = aws_route_table.test-rt.id
}
