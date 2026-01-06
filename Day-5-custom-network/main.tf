#creation of vpc
resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    
    tags = {
        name = "dev"
    }
  
}

# creation of subnet1
resource "aws_subnet" "dev" {
  vpc_id = aws_vpc.name.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "test"
  }
}

#creation of subnet2
resource "aws_subnet" "test" {
    vpc_id = aws_vpc.name.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "us-east-1b"
    tags = {
      Name = "Demo"
    }
  
}
# IG creation
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
  
}
#IG attachment done to VPC

#resource "aws_internet_gateway_attachment" "name" {
   #internet_gateway_id = aws_internet_gateway.name.id
   #vpc_id = aws_vpc.name.id
#}


#creation of routetable
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.name.id
  #Edit routes
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.name.id
  }
}
#subnet association
resource "aws_route_table_association" "name" {
subnet_id = aws_subnet.dev.id
route_table_id = aws_route_table.name.id

  
}

# Create nat gateway for private subnet
# Create route for private subnets and edit routes 
# route table association 

#security group

resource "aws_security_group" "name" {
    vpc_id = aws_vpc.name.id
    description = "allow"
    name = "allow"


   ingress {
    description = "TLS from ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
ingress {
    description = "TLS from ssh"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

#launch an instance
resource "aws_instance" "name" {
  ami = "ami-068c0051b15cdb816"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.dev.id
  vpc_security_group_ids = [aws_security_group.name.id]
  
}

    
  

