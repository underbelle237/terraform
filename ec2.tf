resource "aws_vpc" "prod" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "prod"
  }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name =  "prod"  
  }
}

variable "tag" {
  default = "prod"
}


resource "aws_subnet" "pub-sn" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "public-sn"
  }
}

resource "aws_subnet" "private-sn" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1a"
 
  tags = {
    Name = "private sn"
  }
}

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


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = "private-rt"
  }
}


resource "aws_route_table_association" "pub-route-associate" {
  subnet_id      = aws_subnet.pub-sn.id
  route_table_id = aws_route_table.pub-rt.id
}


resource "aws_route_table_association" "private-route-associate" {
  subnet_id      = aws_subnet.private-sn.id
  route_table_id = aws_route_table.private-rt.id
}


resource "aws_security_group" "public_sg" {
  name_prefix = "public-"
  vpc_id      = aws_vpc.prod.id
  tags = {
    Name = "desamist-public-sg"
  }
}

resource "aws_security_group" "private_sg" {
  name_prefix = "private-"
  vpc_id      = aws_vpc.prod.id
   tags = {
    Name = "desamist-private-sg"
  }
}

resource "aws_security_group_rule" "public_inbound_http" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "private_inbound_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["10.0.1.0/24"] 
  security_group_id = aws_security_group.private_sg.id
}

resource "aws_instance" "public_Instance" {
  ami           = "ami-053b0d53c279acc90" 
  instance_type = "t2.micro"
  key_name      = "demo1"
  subnet_id     = aws_subnet.pub-sn.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "private_Instance" {
  ami           = "ami-053b0d53c279acc90" 
  instance_type = "t2.micro"
  key_name      = "demo1"
  subnet_id     = aws_subnet.private-sn.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = {
    Name = "PrivateInstance"
  }
}