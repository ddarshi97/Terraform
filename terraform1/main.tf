resource "aws_instance" "import_instance" {
    ami                                  = "ami-0590f3a1742b17914"
    instance_type			 = "t2.micro"
    availability_zone                    = "ap-northeast-1a"
    key_name                             = "tokyo_darshan"
}
resource "aws_s3_bucket" "darsh97s3bucket1" {
    bucket                      = "darsh97s3bucket1"
}
resource "aws_vpc" "my-vpc-01" {
    cidr_block                           = "10.0.0.0/24"
}
