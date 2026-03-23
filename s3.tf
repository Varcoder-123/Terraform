provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "23-03-2026"

  tags = {
    Name = "MyBucket"
  }
  
}