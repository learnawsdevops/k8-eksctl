terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

 backend "s3" {
    bucket = "learnawsdevops"
    key    = "eksctl"
    region = "us-east-1"
    dynamodb_table = "learnawsdevops-locking"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

