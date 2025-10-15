
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.16.0"
    }
  }
  backend "s3" {
    bucket = "demo-s3-7541-abc-ind16817314678968123284"
    key = "myTfStateFile.tf"
    region = "us-east-2"
  }
}

provider "aws" {
  region = "us-east-2"
}

resource "aws_instance" "TFBackend_Serv" {
    ami = "ami-077b630ef539aa0b5"
    instance_type = "t2.micro"

    tags = {
        Name = "BackendServer"
    }
}