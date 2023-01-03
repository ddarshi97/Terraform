variable "vpc_cidr_block" {
 description = "giving cidr"
 default = "190.20.60.0/24"
}
variable "availability_zone" {
 description = "assigning availability zone"
 default = {
	"i"="ap-northeast-1a"
	"j"="ap-northeast-1c"
	"k"="ap-northeast-1d"
	}
}
variable "subnet_cidr_block" {
 description = "assigning subnet cidr"
 default = {
	"m"="190.20.60.0/25"
	"n"="190.20.60.128/25"
	}
}
variable "Dest_cidr_block" {
 description = "assigning destination block"
 default = "0.0.0.0/0"
}
variable "instance_count" {
 default = "3"
}
variable "amis" {
 type = map
 default = {
 "us-east-1" = "ami-b374d5a5"
 "ap-northeast-1" = "ami-0590f3a1742b17914"
 }
}
variable "region" {
 default = "ap-northeast-1"
}
