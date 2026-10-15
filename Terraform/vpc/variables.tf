output "vpc_id" {
  value = aws_vpc.ecs_vpc.id
}
output "subnet_id_pub" {
  value = aws_subnet.tc_pub.id
}