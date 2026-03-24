provider "aws" {
  region = "us-east-1"
}

variable "environment" {
  default = "Dev"
  type = string
}

locals {
  bucket_tag_name = "${var.environment}-Bucket"
  instance_tag_name = "${var.environment}-instance"
  vpc_tag_name = "${var.environment}-vpc"
}
//This locals are for Name of the tags and variables are for Environment 
//Variables → used for flexibility (inputs)
//Locals → used for simplifying logic (reuse & calculations)
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "23-03-2026"

  tags = {
    Name = local.bucket_tag_name
    Environment = var.environment
  }

}

resource "aws_instance" "EC2_instance" {
  count              = 2
  ami                = "ami-02dfbd4ff395f2a1b"
  instance_type      = "t2.micro"
  key_name           = "Hashicrop"
  vpc_security_group_ids = ["sg-0c2c1c476b1ffca8a"]   

  tags = {
    Name = local.instance_tag_name
    Environment = var.environment   
  }

  root_block_device {   
    volume_size = 10
    volume_type = "gp3"
  }
}


# S3 Bucket Name
output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket
}

# EC2 Instance IDs
output "instance_id" {
  value = aws_instance.EC2_instance[*].id
}