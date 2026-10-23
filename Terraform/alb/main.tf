resource "aws_lb" "alb_tc" {
    name = "alb-tc"
    internal = false
    load_balancer_type = "application"
    security_groups = [var.alb_sg_id]
    subnets = var.subnet_id_pub
    
}
resource "aws_lb_listener" "HTTPS" {
  load_balancer_arn = aws_lb.alb_tc.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  certificate_arn = var.cert_arn
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_tc_tg.arn
  }
}
resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.alb_tc.arn
  port = 80
  protocol = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }

}
resource "aws_lb_target_group" "alb_tc_tg" {
  port = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id = var.vpc_id
}
