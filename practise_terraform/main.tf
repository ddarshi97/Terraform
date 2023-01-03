resource "aws_vpc" "vpc_01" {
	cidr_block = "194.20.30.0/24"
	tags = {
	Name = "vpc_01"
	}
}
resource "aws_vpc" "vpc_02" {
        provider = aws.virginia
        cidr_block = "194.20.30.0/24"
        tags = {
        Name = "vpc_01"
        }
}
