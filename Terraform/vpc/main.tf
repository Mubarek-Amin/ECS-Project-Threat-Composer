resource "aws_vpc" "ecs_vpc"{
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "ecs_tc_vpc"

    }

}

resource "aws_subnet" "tc_pub"{
 count = 2
 cidr_block = var.cidr_blocks[count.index]
 vpc_id = aws_vpc.ecs_vpc.id
 availability_zone = var.availability_zone[count.index]
}

resource "aws_subnet" "tc_priv"{
 count = 2
 cidr_block = var.cidr_blocks[count.index]
 vpc_id = aws_vpc.ecs_vpc.id
 availability_zone = var.availability_zone[count.index]
}
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.ecs_vpc.id

}
resource "aws_nat_gateway" "ngw" {
  count = 2
  allocation_id = aws_eip.tc-eip[count.index].id
  subnet_id = aws_subnet.tc_pub[count.index].id
  depends_on =  [aws_internet_gateway.igw]
}

resource "aws_route_table" "pub_rt"{
    vpc_id = aws_vpc.ecs_vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "pub-rt-asc" {
    count = 2
    subnet_id = aws_subnet.tc_pub[count.index].id
    route_table_id = aws_route_table.pub_rt.id
    
  
}
resource "aws_route_table" "priv_rt"{
    vpc_id = aws_vpc.ecs_vpc.id
    route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
}
resource "aws_route_table_association" "priv-rt-asc" {
    count = 2
    subnet_id = aws_subnet.tc_priv[count.index].id
    route_table_id = aws_route_table.priv_rt.id
    
  
}
resource "aws_eip" "tc-eip" {
    count = 2
    domain = "vpc"
  
}