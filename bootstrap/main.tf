


resource "aws_ecr_repository" "ECS_TC"{
 name = "ecs_tc"
 image_tag_mutability = "MUTABLE"
 image_scanning_configuration {
   scan_on_push = true
 }
}

resource "aws_s3_bucket" "tc_ecs_s3"{
  bucket = "s3-ecs-tc"
  
  tags= {
    name = "s3_ecs_tc"
  }
}