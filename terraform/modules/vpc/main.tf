resource "aws_vpc" "vpc1" {
  cidr_block           = var.aws_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "eks-vpc"
  }
}

resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.vpc1.id

  tags = {
    Name = "eks-igw"
  }
}

resource "aws_subnet" "pub1a" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.availability_zone[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "eks_public_${count.index + 1}"
  }
}

resource "aws_subnet" "pri1a" {
  count = length(var.private_subnets_cidr)

  vpc_id            = aws_vpc.vpc1.id
  cidr_block        = var.private_subnets_cidr[count.index]
  availability_zone = var.availability_zone[count.index]

  tags = {
    Name = "eks_private_${count.index + 1}"
  }
}
resource "aws_route_table" "rta_pub" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig1.id
  }
  tags = {
    Name = "rta-public"
  }
}
resource "aws_route_table_association" "rta_ass" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.pub1a[count.index].id
  route_table_id = aws_route_table.rta_pub.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "eks-eip-nat"
  }
}

resource "aws_nat_gateway" "aws_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.pub1a[0].id

  tags = {
    Name = "eks-nat"
  }
  depends_on = [aws_internet_gateway.ig1]
}

resource "aws_route_table" "rtaa_pri" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.aws_nat.id
  }
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "aws_rta_ass" {
  count = length(var.private_subnets_cidr)

  subnet_id      = aws_subnet.pri1a[count.index].id
  route_table_id = aws_route_table.rtaa_pri.id
}

resource "aws_security_group" "sg" {
  name        = "allow-group-sg"
  description = "allow sg"
  vpc_id      = aws_vpc.vpc1.id

  ingress {
    description = "allow all inbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "ec2" {
  ami                    = var.public_ami_id
  instance_type          = var.public_instance_type
  subnet_id              = aws_subnet.pub1a[0].id
  vpc_security_group_ids = [aws_security_group.sg.id]
  user_data              = var.install_tool_user_data
  key_name               = "syed"
  tags = {
    Name = var.instance_public_name
  }

}