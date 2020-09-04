resource "aws_vpc" "test-vpc" {
  cidr_block = var.vpc-cidr-block
}

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test-vpc.id
}

resource "aws_subnet" "test-public-subnet" {
  count = var.subnet-count
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = cidrsubnet(var.vpc-cidr-block, 8, count.index + 1)
  map_public_ip_on_launch = "true"
  availability_zone = element(var.availability_zones, count.index)
}


resource "aws_route_table" "test-rt" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }
}

resource "aws_route_table_association" "test-rt-association"{
  count = var.subnet-count
  subnet_id      = element(aws_subnet.test-public-subnet.*.id, count.index)
  route_table_id = aws_route_table.test-rt.id
}
