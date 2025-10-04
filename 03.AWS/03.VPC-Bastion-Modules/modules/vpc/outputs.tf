output "vpc_id" {
  # value = aws_vpc.main.id
  value = aws_vpc.main.id
}

output "public_subnets" {
  value = [for s in aws_subnet.public: s.id]
}

output "private_subnets" {
  value = [for s in aws_subnet.private: s.id]
}

output "availability_zones" {
  value = var.availability_zones
}

output "internet_gateway" {
  value = aws_internet_gateway.gw.id
}

output "route_table_id" {
  value = aws_route_table.main.id
}