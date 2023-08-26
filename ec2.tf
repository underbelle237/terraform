resource "aws_vpc" "prod" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = var.tenancy

  tags = {
    Name = "prod"
  }
}

resource "aws_internet_gateway" "prod" {
  vpc_id = aws_vpc.prod.id

  tags = {
    Name = var.igw_tag  
  }
}


resource "aws_subnet" "pub-sn" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = var.cidr_block_of_pub_sn
  map_public_ip_on_launch = var.auto_assign_public_ip
  availability_zone = var.az_pub_sn
  tags = {
    Name = var.tag_public_sn 
  }
}

resource "aws_subnet" "private-sn" {
  vpc_id     = aws_vpc.prod.id
  cidr_block = var.cidr_block_of_private_sn
  availability_zone = var.az_private_sn
 
  tags = {
    Name = var.tag_private_sn
  }
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.prod.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod.id
  }
  tags = {
    Name = var.tag_pub_rt 
  }
}


resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.prod.id
  tags = {
    Name = var.tag_private_rt
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
    Name = var.public_sgTAG
  }
}

resource "aws_security_group" "private_sg" {
  name_prefix = "private-"
  vpc_id      = aws_vpc.prod.id
   tags = {
    Name = var.private_sgTAG
  }
}

resource "aws_security_group_rule" "public_inbound_http" {
  type        = "ingress"
  from_port   = var.ingress
  to_port     = var.ingress
  protocol    = var.protocol
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public_sg.id
}

resource "aws_security_group_rule" "private_inbound_ssh" {
  type        = "ingress"
  from_port   = var.ingress
  to_port     = var.ingress
  protocol    = var.protocol
  cidr_blocks = [var.cidr_block_of_pub_sn]
  security_group_id = aws_security_group.private_sg.id
}

resource "aws_instance" "public_Instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key
  subnet_id     = aws_subnet.pub-sn.id
  associate_public_ip_address = var.public_ip_association
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  tags = {
    Name = var.public_instanceTAG
  }
}

resource "aws_instance" "private_Instance" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key
  subnet_id     = aws_subnet.private-sn.id
  vpc_security_group_ids = [aws_security_group.private_sg.id]
  tags = {
    Name = var.private_instanceTAG
  }
}