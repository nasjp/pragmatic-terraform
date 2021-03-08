variable "env" {}

locals {
  example_instance_type = var.env == "prod" ? "m5.large" : "t3.micro"
}

data "template_file" "httpd_user_data" {
  template = file("${path.module}/user_data.sh.tpl")

  vars = {
    package = "httpd"
  }
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

resource "aws_security_group" "example_ec2" {
  name = "example-ec2"
}

resource "aws_security_group_rule" "example_ec2_ingress" {
  security_group_id = aws_security_group.example_ec2.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "example_ec2_egress" {
  security_group_id = aws_security_group.example_ec2.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.recent_amazon_linux_2.image_id
  instance_type = local.example_instance_type
  vpc_security_group_ids = [
    aws_security_group.example_ec2.id
  ]
  user_data = data.template_file.httpd_user_data.rendered
}


output "example_public_dns" {
  value = aws_instance.example.public_dns
}
