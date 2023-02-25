terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    awscc = {
      source = "hashicorp/awscc"
      version = "~>0.43.0"
    }
  }
}
