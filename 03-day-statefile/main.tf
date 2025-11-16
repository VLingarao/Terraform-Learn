resource "aws_instance" "dev" {
  ami           = "ami-07a65c5821dc8290c"
  instance_type = "t3.micro"
  key_name      = "aws_key"
}