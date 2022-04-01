# Create a VPC

resource "aws_vpc" "example" {

  cidr_block = "10.0.0.0/16"

}



resource "aws_subnet" "main1" {

  vpc_id     = aws_vpc.example.id

  cidr_block = "10.0.1.0/24"

}



resource "aws_subnet" "main2" {

  vpc_id     = aws_vpc.example.id

  cidr_block = "10.0.2.0/24"

}