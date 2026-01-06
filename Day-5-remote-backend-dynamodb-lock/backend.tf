terraform {
  backend "s3" {
    bucket = "saidharsha123"
    key    = "terraform.tfstate"
    #Enable s3 native locking
    #use_lockfile = true
    region = "us-east-1"
    dynamodb_table = "sree"
  }
}
