# we used variables to prevent hard coding
# makes our more flexible, resusable
# help prevent important secrets from being reflected on our code

variable "vpc_cidr" {
    description = "cidr block of vpc"
    type = string
    default = "10.0.0.0/16"
}

variable "tenancy" {
    description = "tenancy"
    type = string
    default = "default"
}

variable "igw_tag" {
    description = "internet gateway tag"
    type = string
    default = "prod"
}

variable "cidr_block_of_pub_sn" {
    description = "cidr block of public subnet"
    type = string
    default = "10.0.1.0/24"
}
 
 variable "auto_assign_public_ip" {
    description = "auto assign public ip in public subnet"
    type = bool
    default = true
}
 
 variable "tag_public_sn" {
    description = "name tag of public subnet"
    type = string
    default = "public-sn"
 }

  variable "az_pub_sn" {
    description = "availability zone of public subnet"
    type = string
    default = "us-east-1b"
 }

 variable "cidr_block_of_private_sn" {
    description = "cidr block of private subnet"
    type = string
    default = "10.0.2.0/24"
 }

  variable "az_private_sn" {
    description = "availability zone of private subnet"
    type = string
    default = "us-east-1a"
 }

 variable "tag_private_sn" {
    description = "name tag of private subnet"
    type = string
    default = "private-sn"
 }


variable "tag_pub_rt" {
    description = "tag of public route table"
    type = string
    default = "pub-rt"
}

variable "tag_private_rt" {
    description = "tag of private route table"
    type = string
    default = "private-rt"
}


variable "region" {
    description = "region where our resource will be provisioned"
    type = string
    default = "us-east-1"
}

variable "public_sgTAG" {
    description = "public security group"
    type = string
    default = "desamist-public-sg"
}

variable "private_sgTAG" {
    description = "private security group"
    type = string
    default = "desamist-private-sg"
}

variable "ingress" {
    description = "ingress"
    type = string
    default = "22"
}

variable "protocol" {
    description = "protocol"
    type = string
    default = "tcp"
}

variable "ami" {
    description = "our AMI"
    type = string
    default = "ami-053b0d53c279acc90"
}

variable "instance_type" {
    description = "instance type"
    type = string
    default = "t2.micro"
}

variable "key" {
    description = "instance key pair"
    type = string
    default = "class1.pem"
}

variable "public_ip_association" {
    description = "ipublic_ip_association"
    type = string
    default = "true"
}

variable "public_instanceTAG" {
    description = "public_instanceTAG"
    type = string
    default = "public_Desamist_prod"
}

variable "private_instanceTAG" {
    description = "public_instanceTAG"
    type = string
    default = "private_Desamist_prod"
}



