terraform {
    backend "s3"{
        bucket = "s3_ECS"
        key =  "terraform.tfstate"
        use_lockfile = true
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.660"
    }
    
  }
}
provider "aws" {
  region = "us-east-1"
}