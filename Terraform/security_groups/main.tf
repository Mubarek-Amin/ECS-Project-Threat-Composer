resource "aws_security_group" "alb_sg" {
    name = "alb-sg"
    vpc_id = var.vpc_id
  
}
resource "aws_security_group" "ecs_sg" {
  name = "ecs-sg"
  vpc_id = var.vpc_id
}


resource "aws_security_group_rule" "alb_ingress_https" {
    security_group_id = aws_security_group.alb_sg.id
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "tcp"
    from_port = 443
    to_port = 443
    type = "ingress"
}
resource "aws_security_group_rule" "alb_ingress_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_blocks = ["0.0.0.0/0"]
  protocol = "tcp"
  from_port = 80
  to_port = 80
  type = "ingress"
}

resource "aws_security_group_rule" "alb_egress_ecs" {
    source_security_group_id = aws_security_group.ecs_sg.id
    security_group_id = aws_security_group.alb_sg.id
    protocol = "tcp"
    from_port = 3000
    to_port = 3000
    type = "egress"

}
resource "aws_security_group_rule" "ecs_ingress" {
    source_security_group_id = aws_security_group.alb_sg.id
    security_group_id = aws_security_group.ecs_sg.id
    protocol = "tcp"
    from_port = 3000
    to_port = 3000
    type = "ingress"

}
resource "aws_security_group_rule" "ecs_egress" {
    security_group_id = aws_security_group.ecs_sg.id
    protocol = -1
    from_port = 0
    to_port = 0
    type = "ingress"

}

