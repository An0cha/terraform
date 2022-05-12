provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.mysecuritygroup.name]
}

resource "aws_security_group" "mysecuritygroup" {
  name = "Web Access"
  description = "Allow web access"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}