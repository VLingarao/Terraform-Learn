# -----------------------------
# S3 Bucket for Lambda Upload
# -----------------------------
resource "aws_s3_bucket" "lambda_bucket" {
  bucket        = "my-lambda-deployment-bucket-1120"
  force_destroy = true

  tags = {
    Name        = "Lambda Deployment Bucket"
    Environment = "Dev"
  }
}

# Upload Lambda ZIP file to S3
resource "aws_s3_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "lambda.zip"
  source = "lambda.zip"
}

# -----------------------------
# IAM Role for Lambda
# -----------------------------
resource "aws_iam_role" "lambda_role" {
  name = "lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWS Managed Policy for Lambda Logs
resource "aws_iam_role_policy_attachment" "lambda_basic_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# -----------------------------
# Lambda Function
# -----------------------------
resource "aws_lambda_function" "my_lambda" {
  function_name = "my_lambda_function_1234"

  s3_bucket = aws_s3_bucket.lambda_bucket.bucket
  s3_key    = aws_s3_object.lambda_zip.key

  runtime = "python3.9"
  handler = "lambda_function.lambda_handler"
  role    = aws_iam_role.lambda_role.arn

  timeout     = 10
  memory_size = 128
}