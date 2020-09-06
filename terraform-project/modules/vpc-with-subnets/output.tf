output "subnets" {
  value = aws_subnet.public-subnet.*.id
}