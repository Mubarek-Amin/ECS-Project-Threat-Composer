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
    cert_arn = module.route53.cert_arn
    sg_alb = module.security_groups.sg_alb

}
module "route53"{
    source = "./route53"
}

module "security_groups" {
  source = "./security_groups"

}