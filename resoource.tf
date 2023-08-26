# 1 CREATING A VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc

resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod"
  }
}

# create an IGW
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name =  "${var.tag}"  #"prod"
  }
}

variable "tag" {
  default = "prod"
}

# creating subnet public sn
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "pub-sn" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-sn"
  }
}

# private sn
resource "aws_subnet" "private-sn" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
 
  tags = {
    Name = "private sn"
  }
}

# creating a route table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.prod.id
  }

  tags = {
    Name = "pub-rt"
  }
}


# private RT

resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "private-rt"
  }
}

# route table association
# associate our public route table
resource "aws_route_table_association" "pub-route-associate" {
  subnet_id      = aws_subnet.pub-sn.id
  route_table_id = aws_route_table.pub-rt.id
}

#associate private Rt

resource "aws_route_table_association" "private-route-associate" {
  subnet_id      = aws_subnet.private-sn.id
  route_table_id = aws_route_table.private-rt.id
}