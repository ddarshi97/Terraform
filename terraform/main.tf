resource "aws_vpc" "vpc_01" {
 cidr_block = var.vpc_cidr_block
 tags = {
 Name = "vpc_01"
 }
}
resource "aws_vpc" "vpc_02" {
 provider = aws.virginia
 cidr_block = var.vpc_cidr_block
 tags = {
 Name = "vpc_02"
 }
}
resource "aws_internet_gateway" "Igw-01" {
 vpc_id = aws_vpc.vpc_01.id
 tags = {
 Name = "Igw-01"
 }
}
resource "aws_subnet" "public_subnet" {
 vpc_id = aws_vpc.vpc_01.id
 availability_zone = var.availability_zone["i"]
 cidr_block = var.subnet_cidr_block["m"]
 tags = {
 Name = "Public_subnet"
 }
}
resource "aws_route_table" "public_subnet" {
 vpc_id = aws_vpc.vpc_01.id
 tags = {
 Name = "public_route"
 }
}
resource "aws_route" "Igw-01" {
 route_table_id = aws_route_table.public_subnet.id
 destination_cidr_block = var.Dest_cidr_block
 gateway_id = aws_internet_gateway.Igw-01.id
}
resource "aws_route_table_association" "public_subnet" {
 subnet_id = aws_subnet.public_subnet.id
 route_table_id = aws_route_table.public_subnet.id
}
resource "aws_subnet" "private_subnet" {
 vpc_id = aws_vpc.vpc_01.id
 cidr_block = var.subnet_cidr_block["n"]
 availability_zone = var.availability_zone["j"]
 tags = {
 Name = "Private_subnet"
 }
}
resource "aws_route_table" "private_subnet" {
 vpc_id = aws_vpc.vpc_01.id
 tags = {
 Name = "private_route"
 }
}
resource "aws_nat_gateway" "Nat_gw" {
 connectivity_type = "private"
 subnet_id = aws_subnet.public_subnet.id
 tags = {
 Name = "Nat_gw"
 }
}
resource "aws_route" "Nat_gw" {
 route_table_id = aws_route_table.private_subnet.id
 destination_cidr_block = var.Dest_cidr_block
 nat_gateway_id = aws_nat_gateway.Nat_gw.id
}
resource "aws_route_table_association" "private_subnet" {
 subnet_id = aws_subnet.private_subnet.id
 route_table_id = aws_route_table.private_subnet.id
}
resource "aws_instance" "public_instance" {
 count = var.instance_count
 ami = var.amis[var.region]
 associate_public_ip_address = true
 instance_type = "t2.micro"
 subnet_id = aws_subnet.public_subnet.id
 vpc_security_group_ids = ["${aws_security_group.zsecurity.id}"]
 tags = {
 "Name" = "first_instance-${count.index + 1}"
 }
}
resource "aws_security_group" "zsecurity" {
 vpc_id = aws_vpc.vpc_01.id
 ingress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
 egress {
 from_port = 0
 to_port = 0
 protocol = "-1"
 cidr_blocks = ["0.0.0.0/0"]
 }
 tags = {
 "Name" = "zsecurity"
 }
} 
