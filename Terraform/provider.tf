terraform {
    backend "s3"{
        bucket = "s3-ecs-tc"
        key =  "terraform.tfstate"
        use_lockfile = true
        region = "us-east-1"
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.66"
    }
    
  }
}
provider "aws" {
  region = "us-east-1"
}