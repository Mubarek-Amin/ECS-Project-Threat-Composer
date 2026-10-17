module "vpc"{
    source = "./vpc"

}
module "ecs"{
    source = "./ecs"
}
module "alb"{
    source = "./alb"
    vpc_id = module.vpc.vpc_id
    subnet_id_pub = module.vpc.subnet_id_pub
    cert_arn = module.acm.cert_arn
    alb_sg_id = module.security_groups.alb_sg_id

}
module "acm" {
  source = "./acm"
}
module "route53"{
    source = "./route53"
}

module "security_groups" {
  source = "./security_groups"
  vpc_id = module.vpc.vpc_id

}