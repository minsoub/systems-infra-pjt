provider "aws" {
  region = "ap-northeast-2"
}

data "aws_availability_zones" "available" {
    exclude_names = ["ap-northeast-2b", "ap-northeast-2d"]
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
  owners = ["amazon"]
}