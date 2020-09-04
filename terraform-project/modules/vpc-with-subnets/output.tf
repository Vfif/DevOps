output "subnets" {
  value = aws_subnet.test-public-subnet.*.id
}