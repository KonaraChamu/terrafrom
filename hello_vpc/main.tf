provider "aws" {
	region = "eu-west-3"
}

resource "aws_vpc" "hello_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "hello_subnet" {
  vpc_id     = aws_vpc.hello_vpc.id
  cidr_block = "10.0.1.0/24"
}
