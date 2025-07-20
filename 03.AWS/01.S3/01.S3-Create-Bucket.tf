# Create Bucket
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  required_version = ">= 0.12"
}

provider "aws" {
  region = "ap-northeast-1"  # Change to your preferred region  
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = lower("bkt-syed-${replace(replace(timestamp(), ":", "-"), "T", "-")}")  # Must be globally unique
  acl    = "private"

  tags = {
    Name        = "MyBucket"
    Environment = "Dev"
  }
}