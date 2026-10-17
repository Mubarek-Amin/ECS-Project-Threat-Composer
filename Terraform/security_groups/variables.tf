variable "vpc_id" {
  
}
output "alb_sg" {
  value = aws_security_group.alb_sg
}