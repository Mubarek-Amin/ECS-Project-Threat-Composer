terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.660"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

resource "aws_ecr_repository" "ECS_TC"{
 name = "ecs_tc"
 image_tag_mutability = "MUTABLE"
 image_scanning_configuration {
   scan_on_push = true
 }
}