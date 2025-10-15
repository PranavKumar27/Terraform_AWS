
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

provider "aws" {
  region = var.S3Region
}

resource "random_id" "rand_id"{
    byte_length = 8
}

resource "aws_s3_bucket" "demo_bucket"{
    bucket = "demo-s3-7541-abc-ind${random_id.rand_id.dec}"
}



resource "aws_s3_object" "MyFileObj"{
    bucket = aws_s3_bucket.demo_bucket.bucket
    source = "./myfile.txt"
    key = "mydatafile.txt"
}