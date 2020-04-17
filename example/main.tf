locals {
  example_instance_type      = "t3.micro"
  example_instance_type_prod = "m5.large"
}

module "dev_server" {
  source        = "./http_server"
  instance_type = local.example_instance_type
}

output "public_dns" {
  value = module.dev_server.public_dns
}
