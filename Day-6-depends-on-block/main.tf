resource "aws_vpc" "name" {
    cidr_block = "10.0.0.0/16"
    depends_on = [ aws_subnet.name ]
  
}

resource "aws_subnet" "name" {
vpc_id = aws_vpc.name.id
cidr_block = "10.0.0.0/24"

}