resource "aws_instance" "dev" {
  ami = "ami-07a65c5821dc8290c"
  instance_type = "t3.micro"
  key_name = "aws_key"
  user_data = file("userdata.sh")
}

# resource "aws_s3_bucket" "dev_bucket" {
#   bucket = "my-dev-bucket-112020"
#   depends_on = [ aws_instance.dev ]
# }