variable "vpc-cidr-block" {
  default = "172.32.0.0/16"
}

variable "az_num" {
  type = list(number)
  default = [0, 5]//["us-east-1a", "us-east-1f"]
}

variable "nat-gw-for-every-subnet" {
  type = bool
  default = false
}
