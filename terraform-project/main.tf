terraform {
  required_version = ">= 0.12"
  backend "s3" {
    bucket = "testt-buckett"
    region = "us-east-1"
    key = "test.tfstate"
  }
}

provider "aws" {
  region = "us-east-1"
}

/*--------------------VPC------------------*/
module "test-vpc-with-subnets" {
  source = "./modules/vpc-with-subnets"
}
/*-------------------------RDS-------------------------------*/

resource "aws_db_subnet_group" "test-subnet-group" {
  name       = "test-sg"
  subnet_ids = module.test-vpc-with-subnets.subnets
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

/*-------------------------EC2-----------------------------*/

resource "aws_instance" "test-instance" {
  subnet_id = module.test-vpc-with-subnets.subnets[0]
  ami           = "ami-02354e95b39ca8dec"
  instance_type = "t2.micro"
}
