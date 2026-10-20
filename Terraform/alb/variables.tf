variable "vpc_id" {

}
variable "subnet_id_pub"{

}
variable "cert_arn" {
  
}
variable "alb_sg_id" {
 type = string
}

output "tg_arn" {
  value = aws_lb_target_group.alb_tc_tg.arn
}