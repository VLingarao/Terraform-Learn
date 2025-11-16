provider "aws" {
  
}


resource "aws_s3_bucket" "example" {
  bucket = ""
  
}

resource "aws_dynamodb_table" "terraform-dynamodb-state-lock" {
  name         = "terraform-dynamodb-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}