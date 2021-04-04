terraform {
  backend "s3" {
    bucket = "tfstate-pragmatic-terraform-on-aws-nasjp"
    key    = "network/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
