variable "vpc-cidr-block" {
  default = "172.32.0.0/16"
}

variable "availability_zones_num" {
  type = list(number)
  default = [0, 5]//["us-east-1a", "us-east-1f"]
}

