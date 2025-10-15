terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-2"
}

resource "random_id" "rand_id"{
    byte_length = 8 
}
resource "aws_s3_bucket" "mywebapp_bucket" {
  bucket = "mywebapp-bucket${random_id.rand_id.dec}"
}

resource "aws_s3_object" "Index_html" {
    source = "./index.html"
    key = "index.html"
    bucket = aws_s3_bucket.mywebapp_bucket.bucket
    content_type = "text/html"
}

resource "aws_s3_object" "Style_css" {
    source = "./style.css"
    key = "style.css"
    bucket = aws_s3_bucket.mywebapp_bucket.bucket
    content_type = "text/css"
}

resource "aws_s3_bucket_public_access_block" "public-access" {
  bucket = aws_s3_bucket.mywebapp_bucket.bucket

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "allow_public_access"{
    bucket = aws_s3_bucket.mywebapp_bucket.id
    policy = jsonencode(
    {
        Version = "2012-10-17",
        Statement = [
            {
                Action = "s3:GetObject",
                Effect = "Allow",
                Principal = "*",
                Resource = "arn:aws:s3:::${aws_s3_bucket.mywebapp_bucket.id}/*",
                Sid      = "Public Read Object"
            } 
        ] 
    }
    )
}

resource "aws_s3_bucket_website_configuration" "webapp" {
  bucket = aws_s3_bucket.mywebapp_bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "random"{
    value = random_id.rand_id.dec
}

output "bucket_Created"{
    value = aws_s3_bucket.mywebapp_bucket.bucket
}

output "url"{
    value = aws_s3_bucket.mywebapp_bucket.website_endpoint
}