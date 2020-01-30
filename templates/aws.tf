provider "aws" {
  region = "${var.aws_region}"
  version = "~> 2.0"
}

data "aws_caller_identity" "current" {
}

