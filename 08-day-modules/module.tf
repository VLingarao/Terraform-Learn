module "my_module" {
  source       = "../02-day-tfvars"
  ami          = "ami-07a65c5821dc8290c"
  aws_instance = "t3.micro"
  key_name     = "aws_key"
}
