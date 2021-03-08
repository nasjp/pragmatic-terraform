terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-1"
}


module "dev_server" {
  source = "./http_server"
  env    = "dev"
}


output "public_dns" {
  value = module.dev_server.example_public_dns
}
