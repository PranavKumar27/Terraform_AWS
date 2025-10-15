
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
  #  region = "us-east-2"
  region = var.TRregion
}

resource "aws_instance" "myTFserver" {
    # ami = "ami-077b630ef539aa0b5"
    ami = "ami-0cfde0ea8edd312d4"
    instance_type = "t2.micro"

    tags = {
        Name = "NewTerraFormserver"
    }
}