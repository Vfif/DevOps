variable "subnet-count"{
  default =2
}

variable "vpc-cidr-block" {
  default = "172.32.0.0/16"
}

variable "availability_zones" {
  default = ["us-east-1a", "us-east-1f"]
}