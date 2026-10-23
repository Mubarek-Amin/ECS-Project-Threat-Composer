module "vpc"{
    source = "./vpc"

}
module "ecs"{
    source = "./ecs"
    image = data.aws_ecr_repository.ECS_TC.repository_url
    tg_arn = module.alb.tg_arn
    subnet_id_priv = module.vpc.subnet_id_priv
}
module "alb"{
    source = "./alb"
    vpc_id = module.vpc.vpc_id
    subnet_id_pub = module.vpc.subnet_id_pub
    cert_arn = module.acm.cert_arn
    alb_sg_id = module.security_groups.alb_sg_id

}

module "acm"{
    source = "./acm"
    zone_id = data.aws_route53_zone.tc_zone.id
    
}
module "route53"{
    source = "./route53"
    alb_dns_name = module.alb.alb_dns_name
    alb_zone_id = module.alb.alb_zone_id
    zone_id = data.aws_route53_zone.tc_zone.id

}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id

}
data "aws_ecr_repository" "ECS_TC" {
    name = "ecs_tc"
  
}
data "aws_route53_zone" "tc_zone" {
  name = "amin-mubarek.com"
}