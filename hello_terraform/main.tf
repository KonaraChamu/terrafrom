provider "aws" {
	region = "eu-west-3"
}

resource "aws_instance" "instance" {
 ami           = "ami-00983e8a26e4c9bd9"
 instance_type = "t2.micro"
}