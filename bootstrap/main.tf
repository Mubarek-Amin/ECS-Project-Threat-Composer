


resource "aws_ecr_repository" "ECS_TC"{
 name = "ecs_tc"
 image_tag_mutability = "MUTABLE"
 image_scanning_configuration {
   scan_on_push = true
 }
}

resource "aws_s3_bucket" "ECS_S3"{
    bucket = "s3_ECS"
}