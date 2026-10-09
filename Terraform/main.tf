module "vpc"{
    source = "./vpc"
    igw = var.igw
    ngw = var.ngw
    az = var.az
    cidr = var.cidr
    vpc_id = var.vpc_id
    subnet_id_pub = var.subnet_id_pub
    subnet_id_priv = var.subnet_id_priv
    eip_id = var.eip_id
    rt_id_pub = var.rt_id_pub
    rt_id_priv = var.rt_id_priv
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