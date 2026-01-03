resource "aws_instance" "name" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t2.medium"
    tags = {
        Name = "test"
    }
  
}

resource "aws_s3_bucket" "dev" {
    bucket = "saidharsha12345"
  
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.dev.id

  versioning_configuration {
    status = "Enabled"
  }
}