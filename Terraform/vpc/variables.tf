variable "az" {
  default = []
}
variable "cidr" {
  default = []
}
variable"subnet_id_pub"{
    default = aws_subnet.pub[count.index].id
}
variable"subnet_id_priv"{
    default = aws_subnet.priv[count.index].id
}
variable "vpc_id"{
    default = aws_vpc.ecs_vpc.id
}
variable "igw"{
    default = aws_internet_gateway.tc_igw.id
}
variable "rt_id_pub" {
  default = aws_route_table.pub_rt.id
}
variable "rt_id_priv" {
  default = aws_route_table.priv_rt.id
}
variable "ngw"{
    default = aws_nat_gateway.ngw[count.index].id
}
variable "eip_id"{
  default = aws.eip.tc-eip[count.index].id
}