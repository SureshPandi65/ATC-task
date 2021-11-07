resource "aws_vpc" "prod" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = "true"
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public-az1" {
      vpc_id     = aws_vpc.prod.id
      cidr_block = var.public_subnetaz1_cidr
      availability_zone = "us-west-2a"
      tags = {
         Name = var.public_subnetaz1_name
      }
      map_public_ip_on_launch = "true"
}

resource "aws_subnet" "public-az2" {
      vpc_id     = aws_vpc.prod.id
      cidr_block = var.public_subnetaz2_cidr
      availability_zone = "us-west-2b"
      tags = {
         Name = var.public_subnetaz2_name
      }
      map_public_ip_on_launch = "true"
}

resource "aws_subnet" "private-az1" {
      vpc_id     = aws_vpc.prod.id
      cidr_block = var.private_subnetaz1_cidr
      availability_zone = "us-west-2a"
      tags = {
         Name = var.private_subnetaz1_name
      }
      map_public_ip_on_launch = "false"
}

resource "aws_subnet" "private-az2" {
      vpc_id     = aws_vpc.prod.id
      cidr_block = var.private_subnetaz2_cidr
      availability_zone = "us-west-2b"
      tags = {
         Name = var.private_subnetaz2_name
      }
      map_public_ip_on_launch = "false"
}

resource "aws_internet_gateway" "prod-igw" {
      vpc_id = aws_vpc.prod.id
      tags = {
           Name = var.prod_igw_name
      }
}

resource "aws_route_table" "public-rt" {
      vpc_id = aws_vpc.prod.id
      route {
         cidr_block = "0.0.0.0/0"
         gateway_id = aws_internet_gateway.prod-igw.id
      }
      tags = {
        Name = var.public_rt_name
      }
}

resource "aws_route_table" "private-rt" {
     vpc_id = aws_vpc.prod.id
     tags = {
        Name = var.private_rt_name
      }
}

resource "aws_route_table_association" "publicrtwithpublicsubnetaz1" {
     subnet_id = aws_subnet.public-az1.id
     route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "publicrtwithpublicsubnetaz2" {
     subnet_id = aws_subnet.public-az2.id
     route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "privatertwithprivatesubnetaz1" {
     subnet_id = aws_subnet.private-az1.id
     route_table_id = aws_route_table.private-rt.id
}

resource "aws_route_table_association" "privatertwithprivatesubnetaz2" {
     subnet_id = aws_subnet.private-az2.id
     route_table_id = aws_route_table.private-rt.id
}

resource "aws_security_group" "EKS-Controlplane"{
    name = var.ekscp_sg_name
    vpc_id = aws_vpc.prod.id
    egress {
       from_port   = 0
       to_port     = 0
       protocol    = "-1"
       cidr_blocks = ["0.0.0.0/0"]
    }
}

output "pubsubnet01-id" {
   value = aws_subnet.public-az1.id
}

output "pubsubnet02-id" {
   value = aws_subnet.public-az2.id
}

output "privsubnet01-id" {
   value = aws_subnet.private-az1.id
}

output "privsubnet02-id" {
   value = aws_subnet.private-az2.id
}

output "eks-control-sg-id" {
   value = aws_security_group.EKS-Controlplane.id 
}

