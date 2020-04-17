variable "instance_type" {}

provider "aws" {
  region = "ap-northeast-1"
}

data "aws_ami" "recent_amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.????????-x86_64-gp2"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}

data "template_file" "httpd_user_data" {
  template = file("${path.module}/user_data.sh.tpl")

  vars = {
    package = "httpd"
  }
}

resource "aws_instance" "default" {
  ami                    = data.aws_ami.recent_amazon_linux_2.image_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.default.id]
  tags = {
    Name = "example"
  }

  user_data = data.template_file.httpd_user_data.rendered
}

resource "aws_security_group" "default" {
  name = "ec2"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_dns" {
  value = aws_instance.default.public_dns
}
