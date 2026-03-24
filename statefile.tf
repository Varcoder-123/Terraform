provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "aws_s3_bucket" {
  bucket = "23-03-2026"

  tags = {
    Name = "MyBucket"
  }

}
//In this code you have to manually create the s3 bucket later the statefile will upload in s3, but in order to delete the s3 backend you have to delete it first than the s3 bucket manually 
terraform {
  backend "s3" {
    bucket         = "23-03-2026"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}