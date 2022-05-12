provider "aws" {
  region = "us-east-1"
}

# variable  "inputname" {
#   type = string
#   description = "Input Your VPC Name"
# }

resource "aws_vpc" "myvpc" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "AnochaVPC"
  }
}
