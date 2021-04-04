terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "tfstate-pragmatic-terraform-on-aws-nasjp"
    key    = "example/terraform.tfstate"
    region = "ap-northeast-1"
  }
}

provider "aws" {
  region = "ap-northeast-1"

  version = "= 3.31"
}

