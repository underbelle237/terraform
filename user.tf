resource "aws_instance" "prod" {
  ami = "ami-005e54dee72cc1d00" 
  instance_type = "t2.micro"
  count = var.istest == false ? 1 : 0
}

resource "aws_instance" "dev" {
  ami = "ami-005e54dee72cc1d00" 
  instance_type = "t2.micro"
   count = var.istest == true ? 3 : 0
}