resource "aws_ecr_repository" "ECS_TC"{
 name = "ecs_tc"
 image_tag_mutability = "MUTABLE"
 image_scanning_configuration {
   scan_on_push = true
 }
}

resource "aws_s3_bucket" "tc_ecs_s3"{
  bucket = "s3-ecs-tc"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule{
      apply_server_side_encryption_by_default {
        sse_algorithm = "aws:kms"
      }
    }
  }
  
  tags= {
    name = "s3_ecs_tc"
  }
}
data "aws_iam_policy_document" "assume" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
  
  principals {
    type = "Federated"
    identifiers = [data.aws_iam_openid_connect_provider.OIDC.arn]
  } 
  condition {
    test = "StringEquals"
    variable = "token.actions.githubusercontent.com:aud"
    values = ["sts.amazonaws.com"]
  }
  condition {
    test = "StringLike"
    variable = "token.actions.githubusercontent.com:sub"
    values = ["repo:Mubarek-Amin@106826785/ECS-Project-Threat-Composer@1336316203:*"]
  }
}
}
data "aws_iam_policy_document" "permissions" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:*",
      "ec2:*",
      "ecs:*",
      "elasticloadbalancing:*",
      "acm:*",
      "route53:*",
      "iam:*",
      "s3:*"

    ]
    resources = ["*"]

  }
  
}

data "aws_iam_openid_connect_provider" "OIDC" {
  url = "https://token.actions.githubusercontent.com"

}
resource "aws_iam_role" "oidc_role" {
  name = "oidc_tc"
  assume_role_policy = data.aws_iam_policy_document.assume.json
}
resource "aws_iam_role_policy" "oidc_permissions" {
  role = aws_iam_role.oidc_role.name
  policy = data.aws_iam_policy_document.permissions.json
}

