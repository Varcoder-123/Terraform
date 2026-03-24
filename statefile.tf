provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "24-03-2026"

  tags = {
    Name = "MyBucket"
  }

}
//In this code you have to manually create the backed s3 bucket later the statefile will upload in s3, We are creating 2 buckets because we cant create the backend s3 alone as this is not resource. So new s3 bucket will be created along with backend s3 will point to existing bucket
terraform {
  backend "s3" {
    bucket         = "23-03-2026"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}