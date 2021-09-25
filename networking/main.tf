## networking/module

data "aws_availability_zones" "available" {
}
resource "random_shuffle" "az_list" {
  input        = data.aws_availability_zones.available.names # for aws to randomly chose and assign az
  result_count = var.max_subnets
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc-cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
}

# Internet Gateway for the public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
}

#Create var.az_count public subnets, each in a different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = var.pub-sub-cidr[count.index]
  availability_zone       = random_shuffle.az_list.result[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
}

# Create var.az_count private subnets, each in a different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = var.priv-sub-cidr[count.index]
  availability_zone = random_shuffle.az_list.result[count.index]
  vpc_id            = aws_vpc.main.id
}

resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_eip" "gw" {
  count      = var.az_count
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, count.index)
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_nat_gateway.gw.*.id, count.index)
  }
}

resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
