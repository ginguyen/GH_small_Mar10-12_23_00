terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "log_bucket" {
  bucket = "my-tf-log-bucket"
  acl    = "log-delivery-write"
  tags = {
    yor_trace = "364159f5-17e6-4691-a46c-53f4f6d2c2c2"
  }
}
resource "aws_s3_bucket" "foo" {
  acl = "public-read-write"

  bucket = "foo_name"
  versioning {
    enabled = false
  }
  logging {
    target_bucket = aws_s3_bucket.log_bucket.id
    target_prefix = "log/"
  }
  tags = {
    yor_trace = "d1ec59e4-c823-4b09-a07b-a39972d5ae76"
  }
}