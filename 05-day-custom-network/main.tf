#Create VPC 

resource "aws_vpc" "dev" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "dev-vpc"
  }
}

#Create Subnet
resource "aws_subnet" "dev-public" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "public_subnet"
  }
}

resource "aws_subnet" "dev-private" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = "10.0.2.0/24"
  tags = {
    Name = "public_subnet"
  }
}

#Create iG and Attach to VPC
resource "aws_internet_gateway" "dev-ig" {
  vpc_id = aws_vpc.dev.id
  tags = {
    Name = "dev-ig"
  }
}

#Create Rote Table and attach to Subnet
resource "aws_route_table" "dev-public-rt" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev-ig.id
  }
}

#Subnet Route Table Association
resource "aws_route_table_association" "dev-p-rt-accoc" {
  route_table_id = aws_route_table.dev-public-rt.id
  subnet_id      = aws_subnet.dev-public.id
}

#Create Security Group
resource "aws_security_group" "dev-sg" {
  name        = "dev-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.dev.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#Create EC2 Instance
resource "aws_instance" "dev-ec2" {
  ami                    = "ami-07a65c5821dc8290c"
  instance_type          = "t3.micro"
  key_name               = "aws_key"
  subnet_id              = aws_subnet.dev-public.id
  vpc_security_group_ids = [aws_security_group.dev-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "dev-ec2"
  }
}
