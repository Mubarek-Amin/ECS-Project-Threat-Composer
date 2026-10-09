resource "aws_vpc" "ecs_vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "ecs_tc_vpc"

    }

}

resource "aws_subnet" "tc_pub"{
 count = 2
 cidr_block = var.cidr[count.index]
 vpc_id = aws_vpc.ecs_vpc.id
 availability_zone = var.az[count.index]
}

resource "aws_subnet" "tc_priv"{
 count = 2
 cidr_block = var.cidr[count.index]
 vpc_id = aws_vpc.ecs_vpc.id
 availability_zone = var.az[count.index]
}
resource "aws_internet_gateway""igw"{
    vpc_id = var.vpc_id

}
resource "aws_nat_gateway" "ngw" {
  count = 2
  allocation_id = var.eip_id
  subnet_id = var.subnet_id_pub
  depends_on =  [var.igw]
}

resource "aws_route_table" "pub_rt"{
    vpc_id = var.vpc_id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = var.igw
    }
}
resource "aws_route_table_association" "pub-rt-asc" {
    
    subnet_id = var.subnet_id_pub
    route_table_id = var.rt_id_pub
    
  
}
resource "aws_route_table" "priv_rt"{
    vpc_id = var.vpc_id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = var.ngw
    }
}
resource "aws_route_table_association" "priv-rt-asc" {
    
    subnet_id = var.subnet_id_priv
    route_table_id = var.rt_id_priv
    
  
}
resource "aws_eip" "tc-eip" {
    count = 2
    domain = "vpc"
  
}