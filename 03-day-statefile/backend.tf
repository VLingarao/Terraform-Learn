terraform {
  backend "s3" {
    bucket = "my-terrafrom-bucket-2025"
    key = "terraform.tfstate"
    region = "ap-south-2"
  }
}