

provider "aws" {
	region = "eu-west-3"
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "http_sg" {
  name        = "http_sg"
  description = "Allow HTTP inbound traffic"
  vpc_id =  aws_default_vpc.default.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

	egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
 ami           = "ami-00983e8a26e4c9bd9"
 instance_type = "t2.micro"
 associate_public_ip_address = true
 vpc_security_group_ids = [aws_security_group.http_sg.id]

 user_data = <<-EOF
  #!/bin/bash
  apt-get update
  apt-get install -y apache2
  echo "Hello Terraform" > /var/www/html/index.html
  EOF
}
