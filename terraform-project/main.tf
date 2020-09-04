terraform {
  backend "s3" {
    bucket = "testt-buckett"
    region = "us-east-1"
    key = "test.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

--------------------VPC------------------


resource "aws_vpc" "test-vpc" {
  cidr_block = "172.32.0.0/16"
}

resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.test-vpc.id
}

resource "aws_subnet" "test-public-subnet" {
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = "172.32.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
}

resource "aws_subnet" "test1-public-subnet" {
  vpc_id = aws_vpc.test-vpc.id
  cidr_block = "172.32.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1f"
}

resource "aws_route_table" "test-rt" {
  vpc_id = aws_vpc.test-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-gw.id
  }
}

resource "aws_route_table_association" "test-rt-association"{
  subnet_id = aws_subnet.test-public-subnet.id
  route_table_id = aws_route_table.test-rt.id
}

-------------------------RDS-------------------------------


resource "aws_db_subnet_group" "test-subnet-group" {
  name       = "test-sg"
  subnet_ids = [aws_subnet.test-public-subnet.id, aws_subnet.test1-public-subnet.id]
}

resource "aws_db_instance" "test-db" {
  allocated_storage    = 5
  db_subnet_group_name = aws_db_subnet_group.test-subnet-group.name
  engine               = "postgres"
  engine_version       = "11.5"
  identifier           = "test-db"
  instance_class       = "db.m5.large"
  skip_final_snapshot  = true
  storage_encrypted    = true
  username             = "postgres"
  password             = "password"
}

-------------------------EC2-----------------------------


resource "aws_instance" "test-instance" {
  subnet_id = aws_subnet.test-public-subnet.id
  ami           = "ami-02354e95b39ca8dec"
  instance_type = "t2.micro"
}
