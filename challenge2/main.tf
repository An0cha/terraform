provider "aws" {
  region = "us-east-1"
}
resource "aws_instance" "DB" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  tags = {
    "name" = "DB Server"
  }
}

resource "aws_instance" "WEB" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.WebAccss.name]
  user_data = file("server-script.sh")
  tags = {
    "name" = "Web Server"
  }
}

variable "ingressrules" {
  type = list(number)
  default = [ 80, 443 ]
}

variable "egressrules" {
  type = list(number)
  default = [ 80, 443 ]
}

resource "aws_security_group" "WebAccss" {
  name = "WEB TRAFFIC"
  dynamic "ingress"{
      iterator = port
      for_each = var.ingressrules
      content {
          from_port     = port.value
          to_port       = port.value
          protocol      = "TCP"
          cidr_blocks   = ["0.0.0.0/0"]
      }
  }
  dynamic "egress"{
      iterator = port
      for_each = var.egressrules
      content {
          from_port     = port.value
          to_port       = port.value
          protocol      = "TCP"
          cidr_blocks   = ["0.0.0.0/0"]
      }
  }

}

resource "aws_eip" "EIP" {
  instance = aws_instance.WEB.id
}

output "PrivateIP" {
  value = aws_instance.DB.private_ip
}

output "PublicEIP" {
  value = aws_eip.EIP.public_ip
}