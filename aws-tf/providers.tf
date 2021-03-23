terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    profile        = "test"
    region         = "eu-central-1"
    bucket         = "biz-tf-state"
    key            = "stage1/state"

    dynamodb_table = "tf-locks"
    encrypt        = true
  }
}

provider "aws" {
  region           = var.region
  profile          = var.profile
}