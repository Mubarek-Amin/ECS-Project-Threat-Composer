output "vpc_id" {
  value = aws_vpc.ecs_vpc.id
}
output "subnet_id_pub" {

  value = aws_subnet.tc_pub[*].id
}
variable "availability_zone" {
  default = ["us-east-1a","us-east-1b"]
}
variable "cidr_blocks" {
  default = ["10.0.1.0/24","10.0.2.0/24"]
  
}