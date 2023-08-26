# we used variables to prevent hard coding
# makes our more flexible, resusable
# help prevent important secrets from being reflected on our code



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
    default = "demo1"
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



