terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0" # or latest version like 5.45.0
    }
  }
}

provider "aws" {
  region = "us-east-1" # ya jo bhi aapki region ho
}

