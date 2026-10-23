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
output "alb_zone_id" {
  value = aws_lb.alb_tc.zone_id
}
output "alb_dns_name" {
  value = aws_lb.alb_tc.dns_name
}