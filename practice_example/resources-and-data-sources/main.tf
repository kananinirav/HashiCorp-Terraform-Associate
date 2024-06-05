provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "dev-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "terraform-demo"
    "terraform" = true
  }
}

resource "aws_subnet" "dev-subnet-1" {
  vpc_id = aws_vpc.dev-vpc.id
  cidr_block = "10.0.10.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    "Name" = "terraform-demo"
    "terraform" = true
  }
}

# create new subnet in existing-vpc

data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "existing-vpc-new-subnet" {
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-northeast-1a"

  tags = {
    "Name" = "existing-vpc-new-subnet"
    "terraform" = true
  }
}

# querying existing resources with tag

data "aws_vpc" "existing-vpc-with-tag" {
  filter {
    name   = "tag:Name"
    values = ["Default VPC"]
  }
}
output "vpc_id" {
  value = data.aws_vpc.existing-vpc-with-tag.id
}
