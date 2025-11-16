resource "aws_instance" "dev" {
  ami = var.ami
  instance_type = var.aws_instance
  key_name = var.key_name
}