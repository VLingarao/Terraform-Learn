resource "aws_instance" "name" {
  ami = "ami-07a65c5821dc8290c"
  instance_type = "t3.micro"
  key_name = "aws_key"

  lifecycle {
    create_before_destroy = true
  }
#   lifecycle {
#     ignore_changes = [ tags, ]
#   }
#   lifecycle {
#     prevent_destroy = true
#   }

#terraform apply -target=aws_s3_bucket.dependent
#terraform plan -target=aws_s3_bucket.dependent
#terraform destroy -target=aws_s3_bucket.dependent

}
