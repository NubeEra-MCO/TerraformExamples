resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  for_each = toset(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.key
  availability_zone       = element(var.availability_zones, index(var.public_subnet_cidrs, each.key))
  map_public_ip_on_launch = true
  tags = {
    Name = "Public subnet ${each.key}"
  }
}

resource "aws_subnet" "private" {
  for_each = tomap(zipmap(var.availability_zones, var.private_subnet_cidrs))
  vpc_id = aws_vpc.main.id
  cidr_block = each.value
  availability_zone = each.key

  tags = {
    Name = "private-subnet-${each.key}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

# Create a route table
resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id
}

# Public Subnets route table association
resource "aws_route_table_association" "public_subnet_association" {
  for_each         = aws_subnet.public
  subnet_id        = each.value.id
  route_table_id   = aws_route_table.main.id
}

# Create a route for internet access in public subnets
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.main.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}



