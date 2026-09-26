module "vpc"{
    source = "./vpc"
}
module "ecs"{
    source = "./ecs"
}
module "alb"{
    source = "./alb"
}
module "route53"{
    source = "./route53"
}
module "iam"{
    source = "./iam"
}